import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_icon_sizes.dart';
import '../constants/app_icons.dart';
import '../constants/app_spacing.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: ExpertiseTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.inputHeight),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: _isPasswordHidden,
            textInputAction: widget.textInputAction,
            style: ExpertiseTextStyles.inputText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: ExpertiseTextStyles.inputHint,
              filled: true,
              fillColor: AppColors.surfaceColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: AppSpacing.inputHeight,
              ),
              suffixIcon: IconButton(
                onPressed: _togglePasswordVisibility,
                icon: SvgPicture.asset(
                  AppIcons.eye,
                  width: AppIconSizes.passwordEyeWidth,
                  height: AppIconSizes.passwordEyeHeight,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textMutedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                borderSide: const BorderSide(color: AppColors.inputBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                borderSide: const BorderSide(
                  color: AppColors.inputFocusedBorderColor,
                  width: 1.4,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 1.4,
                ),
              ),
              errorStyle: ExpertiseTextStyles.error,
            ),
          ),
        ),
      ],
    );
  }
}
