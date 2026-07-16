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
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_loaded) return;

    _loaded = true;

    context.read<HomeCubit>().loadHomeData();

    context.read<RequestCubit>().loadRequests();
  }

  Future<void> _refresh() async {
    await Future.wait([
      context.read<HomeCubit>().refresh(),
      context.read<RequestCubit>().refreshRequests(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeFailure) {
              return ListView(
                children: [
                  const SizedBox(height: 180),
                  Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeCubit>().loadHomeData();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is HomeLoaded) {
              final stats = state.stats;

              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff001A2C),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Here's your professional overview for today.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  DashboardCard(
                    title: "TOTAL JOBS",
                    value: stats.totalJobs.toString(),
                    backgroundColor: const Color(0xffEBF5FF),
                    topLeftWidget: const SizedBox(),
                    isCentered: true,
                  ),

                  const SizedBox(height: 18),

                  DashboardCard(
                    title: "Rating",
                    value: stats.rating.toStringAsFixed(1),
                    backgroundColor: Colors.white,
                    topLeftWidget: const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 32,
                    ),
                    topRightWidget: const SizedBox(),
                    bottomSubtitle: Text(
                      "/5.0 (${stats.reviews} Reviews)",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Latest Client Requests",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff001A2C),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const LatestRequestsListView(),

                  const SizedBox(height: 28),

                  const PostNewServiceButton(),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}