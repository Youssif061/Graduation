import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/dashboard_card.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/latest_requests_list_view.dart';
import 'package:expertisemarket/features/ServiceProvider/home/widget/post_new_service_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Welcome back, Alex',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001A2C),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Here's your professional overview for today.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.darkGreyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardCard(
                    backgroundColor: const Color(0xFFEBF5FF),
                    title: 'TOTAL JOBS',
                    value: '142',
                    topLeftWidget: const SizedBox(),
                    topRightWidget: null,
                  ),

                  const SizedBox(height: 16),

                  DashboardCard(
                    backgroundColor: Colors.white,
                    title: 'Rating',
                    value: '4.9',
                    topLeftWidget: const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 32,
                    ),
                    bottomSubtitle: Text(
                      '/ 5.0 (88 reviews)',
                      style: TextStyle(
                        color: AppColors.darkGreyColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    topRightWidget: SizedBox(
                      width: 40,
                      height: 24,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: 12,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppImages.User,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppImages.User,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Client Requests',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF001A2C),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFF006D37),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  LatestRequestsListView(),

                  SizedBox(height: 24),

                  PostNewServiceButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
