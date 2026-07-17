import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/confirmEmail.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_state.dart';
import 'package:expertisemarket/features/Auth_1/cubit/worker_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();

  LatLng currentLocation = const LatLng(30.0444, 31.2357);
  String? locationError;
  bool loading = true;
  double selectedRadius = 1000;

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        locationError = null;
      });

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() {
          loading = false;
          locationError = "Please enable Location Service.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          loading = false;
          locationError = "Location permission is required.";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          forceLocationManager: false,
        ),
      );

      if (!mounted) return;

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        loading = false;
      });

      mapController.move(currentLocation, 15);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        locationError = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Worker account created successfully"),
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => confirmEmail()),
            (route) => false,
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Choose Your Location",
              style: TextStyles.subtitle2,
            ),
            centerTitle: false,
          ),
          body: MyBodyView(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: currentLocation,
                          initialZoom: 15,
                          onTap: (tapPosition, point) {
                            setState(() {
                              currentLocation = point;
                            });
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName: "com.example.expertisemarket",
                          ),
                          CircleLayer(
                            circles: [
                              CircleMarker(
                                point: currentLocation,
                                radius: selectedRadius,
                                useRadiusInMeter: true,
                                color: Colors.blue.withAlpha(20),
                                borderColor: Colors.blue,
                                borderStrokeWidth: 2,
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: currentLocation,
                                width: 55,
                                height: 55,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: _getCurrentLocation,
                            icon: const Icon(Icons.my_location),
                            label: const Text("Use Current Location"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Service Radius : ${(selectedRadius / 1000).toStringAsFixed(0)} km",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        Slider(
                          value: selectedRadius,
                          min: 1000,
                          max: 100000,
                          divisions: 99,
                          label:
                              "${(selectedRadius / 1000).toStringAsFixed(0)} km",
                          onChanged: (value) {
                            setState(() {
                              selectedRadius = value;
                            });
                          },
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    context
                                        .read<WorkerSignupCubit>()
                                        .saveLocation(
                                          location: currentLocation,
                                          radius: selectedRadius,
                                        );

                                    final worker = context
                                        .read<WorkerSignupCubit>()
                                        .state;

                                    context.read<AuthCubit>().signUpWorker(
                                      imageUrl: worker.imageUrl,
                                      name: worker.name,
                                      email: worker.email,
                                      phone: worker.phone,
                                      password: worker.password,
                                      category: worker.category,
                                      experience: worker.experience,
                                      nationalId: worker.nationalId,
                                      latitude: worker.location!.latitude,
                                      longitude: worker.location!.longitude,
                                      radius: worker.radius,
                                    );
                                  },
                            icon: const Icon(Icons.check_circle),
                            label: state is AuthLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Confirm Location",
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        if (locationError != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    locationError!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
