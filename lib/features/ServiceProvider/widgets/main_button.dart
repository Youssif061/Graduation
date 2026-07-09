import 'package:craftmarket/core/styles/coloras.dart';
import 'package:craftmarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text = '',
    this.width = double.infinity,
    this.height = 67,
    required this.onPress,
    this.background = AppColors.primaryColor,
    this.textStyle,
    this.child,
  });

  final String text;
  final double width;
  final double height;
  final VoidCallback onPress;
  final Color background;
  final TextStyle? textStyle;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(width, height),
      ),
      onPressed: onPress,
      child: child ??
          Text(
            text,
            style: textStyle ?? TextStyles.body,
          ),
    );
  }
}