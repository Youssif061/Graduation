import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';

enum PrimaryButtonVariant { dark, green, outlined }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final PrimaryButtonVariant variant;
  final IconData? icon;
  final double height;
  final double? width;
  final double fontSize;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = PrimaryButtonVariant.dark,
    this.icon,
    this.height = 50,
    this.width,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case PrimaryButtonVariant.green:
        bg = AppColors.marketGreen;
        textColor = Colors.white;
        borderColor = AppColors.marketGreen;
        break;
      case PrimaryButtonVariant.outlined:
        bg = Colors.transparent;
        textColor = AppColors.marketText;
        borderColor = AppColors.marketText;
        break;
      case PrimaryButtonVariant.dark:
        bg = AppColors.marketText; // Dark slate color from palette
        textColor = Colors.white;
        borderColor = AppColors.marketText;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: MarketTextStyles.buttonText.copyWith(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
