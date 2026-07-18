import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';

class MarketSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const MarketSearchBar({
    super.key,
    this.onTap,
    this.readOnly = false,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.marketInputBg, // Soft blue-grey background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search, color: AppColors.marketTextSub, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: readOnly
                  ? Text(
                      'Search premium tools & hardware...',
                      style: MarketTextStyles.bodySmall.copyWith(fontSize: 14, color: AppColors.marketTextSub),
                    )
                  : TextField(
                      controller: controller,
                      onChanged: onChanged,
                      autofocus: true,
                      style: MarketTextStyles.bodyMedium.copyWith(
                        color: AppColors.marketText,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search premium tools & hardware...',
                        hintStyle: MarketTextStyles.bodySmall.copyWith(
                          fontSize: 14,
                          color: AppColors.marketTextMuted,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      cursorColor: AppColors.marketGreen,
                    ),
            ),
            const SizedBox(width: 10),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}
