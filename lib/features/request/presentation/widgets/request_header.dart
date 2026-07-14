import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestHeader extends StatelessWidget {
  const RequestHeader({super.key, required this.onNotificationTap});

  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.marketCard,
        border: Border(bottom: BorderSide(color: AppColors.marketBorder)),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              AppImages.User,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'ExpertiseMarket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.marketText,
              ),
            ),
          ),
          IconButton(
            onPressed: onNotificationTap,
            icon: SvgPicture.asset(
              AppImages.notificationsSvg,
              width: 16,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
