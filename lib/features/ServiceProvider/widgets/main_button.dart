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
    this.foreground = Colors.white,
    this.textStyle,
    this.child,
    this.icon,
    this.isLoading = false,
    this.borderRadius = 20,
    this.elevation = 0,
  });

  final String text;

  final double width;
  final double height;

  final VoidCallback? onPress;

  final Color background;
  final Color foreground;

  final TextStyle? textStyle;

  final Widget? child;
  final Widget? icon;

  final bool isLoading;

  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final bool enabled =
        onPress != null && !isLoading;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPress : null,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor:
              background.withOpacity(.55),
          disabledForegroundColor:
              foreground.withOpacity(.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 250,
          ),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey(
                    'loading',
                  ),
                  width: 24,
                  height: 24,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: foreground,
                  ),
                )
              : child ??
                  Row(
                    key: const ValueKey(
                      'content',
                    ),
                    mainAxisSize:
                        MainAxisSize.min,
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                      Flexible(
                        child: Text(
                          text,
                          overflow:
                              TextOverflow
                                  .ellipsis,
                          style:
                              textStyle ??
                                  TextStyles.body,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}