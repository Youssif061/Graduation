import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/cubit/notification_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/widget/activity_card.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit()..loadNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,

        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,

          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: SvgPicture.asset(
                AppImages.backSvg,
                width: 20,
                height: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff001A2C),
                ),
              ),
            ),
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
          ),
        ),

        body: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },

          builder: (context, state) {
            final cubit = context.read<NotificationCubit>();

            if (state is NotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is NotificationLoaded) {
              final notifications = state.notifications;

              if (notifications.isEmpty) {
                return const Center(
                  child: Text(
                    "No Notifications Yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: cubit.refresh,

                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),

                  children: [

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Activity",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge,
                        ),

                        TextButton(
                          onPressed: () {
                            cubit.markAllAsRead();
                          },
                          child: const Text(
                            "Mark all as read",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const SectionHeader(
                      title: "Notifications",
                    ),

                    const SizedBox(height: 16),

                    ...notifications.map(
                      (notification) => ActivityCard(
                        notification: notification,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is NotificationUpdating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}