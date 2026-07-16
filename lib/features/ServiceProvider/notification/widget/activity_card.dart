import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/cubit/notification_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.notification,
  });

  final NotificationModel notification;

  String get timeText {
    final difference = DateTime.now().difference(notification.createdAt);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    return "${difference.inDays} days ago";
  }

  String get iconPath {
    switch (notification.icon) {
      case "payment":
        return AppImages.correctSvg;

      case "proposal":
        return AppImages.workSvg;

      case "message":
        return AppImages.messageSvg;

      case "inventory":
        return AppImages.inventorySvg;

      case "security":
        return AppImages.protectSvg;

      default:
        return AppImages.messageSvg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification.id),

      direction: DismissDirection.endToStart,

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      onDismissed: (_) {
        context
            .read<NotificationCubit>()
            .deleteNotification(notification.id);
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: SvgPicture.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            notification.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkColor,
                            ),
                          ),
                        ),

                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),

                        const SizedBox(width: 8),

                        Text(
                          timeText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      notification.message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGreyColor,
                        height: 1.5,
                      ),
                    ),

                    if (notification.isVerified) ...[
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xffE8F7EE),
                          borderRadius: BorderRadius.circular(6),
                        ),

                        child: const Text(
                          "VERIFIED",
                          style: TextStyle(
                            color: Color(0xff27AE60),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}