import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final String time;
  final bool isVerified;
  final bool hasUnreadDot;

  const ActivityCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isVerified = false,
    this.hasUnreadDot = false,
  });

  Map<String, Color> _getIconColors() {
    if (iconPath.contains('correctSvg') || isVerified) {
      return {'bg': const Color(0xFFE8F7EE), 'icon': const Color(0xFF27AE60)};
    } else if (iconPath.contains('workSvg')) {
      return {'bg': const Color(0xFFE8F1FF), 'icon': const Color(0xFF2F80ED)};
    } else if (iconPath.contains('messageSvg')) {
      return {'bg': const Color(0xFFFFF4E5), 'icon': const Color(0xFFD35400)};
    } else if (iconPath.contains('inventoryServiceProviderSvg')) {
      return {'bg': const Color(0xFFF0F2F5), 'icon': const Color(0xFF4F5E7B)};
    } else {
      return {'bg': const Color(0xFFF1F3F6), 'icon': const Color(0xFF6C7A89)};
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColors = _getIconColors();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.04),
            blurRadius: 14,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(iconPath, width: 44, height: 44),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (hasUnreadDot) ...[
                              const SizedBox(width: 6),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF27AE60),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.darkGreyColor,
                      height: 1.45,
                    ),
                  ),

                  if (isVerified) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F7EE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'VERIFIED',
                        style: TextStyle(
                          color: Color(0xFF27AE60),
                          fontWeight: FontWeight.bold,
                          fontSize: 9.5,
                          letterSpacing: 0.5,
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
    );
  }
}
