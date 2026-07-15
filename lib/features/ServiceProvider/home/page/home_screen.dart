import 'package:expertisemarket/features/ServiceProvider/home/cubit/home_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/home/cubit/home_state.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/dashboard_card.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/latest_requests_list_view.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/post_new_service_button.dart';
import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isDataLoaded) {
      _isDataLoaded = true;

      /// سيتم استبدال providerId بالـ uid الحقيقي بعد ربط Firebase
      context.read<HomeCubit>().loadHomeData(providerId: "providerId");

      /// تحميل آخر الطلبات
      context.read<RequestCubit>().loadRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeFailure) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (state is HomeLoaded) {
            final stats = state.stats;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A2C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Here's your professional overview for today.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    DashboardCard(
                      backgroundColor: const Color(0xFFEBF5FF),
                      title: "TOTAL JOBS",
                      value: stats.totalJobs.toString(),
                      topLeftWidget: const SizedBox(),
                      isCentered: true,
                    ),

                    const SizedBox(height: 16),

                    DashboardCard(
                      backgroundColor: Colors.white,
                      title: "Rating",
                      value: stats.rating.toStringAsFixed(1),
                      topLeftWidget: const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 32,
                      ),
                      bottomSubtitle: Text(
                        "/5.0 (${stats.reviews} Reviews)",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      topRightWidget: const SizedBox(),
                    ),

                    const SizedBox(height: 30),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Client Requests",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001A2C),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const LatestRequestsListView(),

                    const SizedBox(height: 24),

                    const PostNewServiceButton(),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
