import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocateOnMap extends StatefulWidget {
  const LocateOnMap({super.key});

  @override
  State<LocateOnMap> createState() => _LocateOnMapState();
}

class _LocateOnMapState extends State<LocateOnMap> {
  final MapController mapController = MapController();

  LatLng currentLocation = const LatLng(30.0444, 31.2357);

  bool loading = true;
  String address = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() => loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() => loading = false);
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    currentLocation = LatLng(position.latitude, position.longitude);

    await _getAddress();

    setState(() {
      loading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        mapController.move(currentLocation, 15);
      }
    });
  }

  Future<void> _getAddress() async {
    try {
      List<Placemark> place = await placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );

      final p = place.first;

      address = "${p.street}, ${p.locality}, ${p.administrativeArea}";
    } catch (_) {
      address = "${currentLocation.latitude}, ${currentLocation.longitude}";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Choose Location")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 15,
                onTap: (_, point) async {
                  currentLocation = point;

                  await _getAddress();

                  setState(() {});
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "com.example.expertisemarket",
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentLocation,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.location_on,
                        size: 45,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(address, textAlign: TextAlign.center),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text("Use Current Location"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "address": address,
                        "lat": currentLocation.latitude,
                        "lng": currentLocation.longitude,
                      });
                    },
                    child: const Text("Confirm Location"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
