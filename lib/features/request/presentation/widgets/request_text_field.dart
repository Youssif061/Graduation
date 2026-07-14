import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestTextField extends StatelessWidget {
  const RequestTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.prefixText,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.marketText,
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          style: const TextStyle(fontSize: 15, color: AppColors.marketText),
          decoration: InputDecoration(
            hintText: hintText,
            prefixText: prefixText,
            hintStyle: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: AppColors.marketTextMuted,
            ),
            filled: true,
            fillColor: AppColors.marketCard,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            enabledBorder: _border(AppColors.inputBorderColor),
            focusedBorder: _border(AppColors.marketGreenDark, width: 1.4),
            errorBorder: _border(AppColors.marketRed),
            focusedErrorBorder: _border(AppColors.marketRed, width: 1.4),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
