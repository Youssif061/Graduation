import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text = '',
    this.width = double.infinity,
    this.height = 60,
    this.onPress,
    this.background = AppColors.primaryColor,
    this.textStyle,
    this.child,
    this.icon,
    this.isLoading = false,
  });

  final String text;

  final double width;

  final double height;

  /// يصبح null عند تعطيل الزر
  final VoidCallback? onPress;

  final Color background;

  final TextStyle? textStyle;

  final Widget? child;

  /// أيقونة اختيارية
  final Widget? icon;

  /// لإظهار مؤشر التحميل
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: background,
          disabledBackgroundColor: background.withOpacity(.5),
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: textStyle ?? TextStyles.body,
                    ),
                  ],
                ),
      ),
    );
  }
}