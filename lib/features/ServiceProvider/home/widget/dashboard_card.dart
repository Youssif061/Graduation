import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget topLeftWidget;
  final Widget? topRightWidget;
  final Widget? bottomSubtitle;
  final Color backgroundColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.topLeftWidget,
    this.topRightWidget,
    this.bottomSubtitle,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final bool centered = topLeftWidget is SizedBox && topRightWidget == null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: centered
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreyColor,
                    letterSpacing: .5,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff001A2C),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [topLeftWidget, ?topRightWidget],
                ),

                const SizedBox(height: 12),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreyColor,
                    letterSpacing: .5,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff001A2C),
                      ),
                    ),

                    if (bottomSubtitle != null) ...[
                      const SizedBox(width: 6),
                      bottomSubtitle!,
                    ],
                  ],
                ),
              ],
            ),
    );
  }
}
