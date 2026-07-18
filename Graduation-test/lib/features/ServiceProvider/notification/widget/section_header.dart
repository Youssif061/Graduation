import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.greyColor.withOpacity(
              0.3,
            ),
          ),
        ),
      ],
    );
  }
}