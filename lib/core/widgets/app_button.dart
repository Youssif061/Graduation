import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_spacing.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

enum AppButtonIconPosition {
  leading,
  trailing,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.iconPath,
    this.iconWidth,
    this.iconHeight,
    this.iconPosition = AppButtonIconPosition.leading,
    this.backgroundColor = AppColors.navyColor,
    this.foregroundColor = AppColors.surfaceColor,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final String? iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final AppButtonIconPosition iconPosition;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      height: AppSpacing.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: AppColors.greyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            color: AppColors.surfaceColor,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _buildContent(),
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    final Widget titleWidget = Text(
      title,
      style: ExpertiseTextStyles.button.copyWith(
        color: foregroundColor,
      ),
    );

    if (iconPath == null) {
      return [titleWidget];
    }

    final double resolvedIconWidth = iconWidth ?? AppSpacing.iconSize;
    final double resolvedIconHeight = iconHeight ?? resolvedIconWidth;

    final Widget iconWidget = SvgPicture.asset(
      iconPath!,
      width: resolvedIconWidth,
      height: resolvedIconHeight,
      colorFilter: ColorFilter.mode(
        foregroundColor,
        BlendMode.srcIn,
      ),
    );

    if (iconPosition == AppButtonIconPosition.trailing) {
      return [
        titleWidget,
        const SizedBox(width: AppSpacing.sm),
        iconWidget,
      ];
    }

    return [
      iconWidget,
      const SizedBox(width: AppSpacing.sm),
      titleWidget,
    ];
  }
}