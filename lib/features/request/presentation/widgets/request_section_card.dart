import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class RequestSectionCard extends StatelessWidget {
  const RequestSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.marketText.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
