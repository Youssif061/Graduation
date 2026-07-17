import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.topLeftWidget,
    this.topRightWidget,
    this.bottomSubtitle,
    this.backgroundColor = Colors.white,
    this.isCentered = false,
  });

  final String title;
  final String value;

  final Widget topLeftWidget;
  final Widget? topRightWidget;
  final Widget? bottomSubtitle;

  final Color backgroundColor;

  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isCentered
          ? _buildCenteredCard()
          : _buildDefaultCard(),
    );
  }

  Widget _buildCenteredCard() {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreyColor,
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
    );
  }

  Widget _buildDefaultCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topLeftWidget,
            if (topRightWidget != null) topRightWidget!,
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreyColor,
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
              Flexible(child: bottomSubtitle!),
            ],
          ],
        ),
      ],
    );
  }
}