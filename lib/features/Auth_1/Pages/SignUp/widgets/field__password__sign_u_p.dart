import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Field_Password_SignUP extends StatelessWidget {
  const Field_Password_SignUP({
    super.key,
    required this.Title,
    this.controller,
  });

  final String Title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(25),
        Text(
          Title,
          style: TextStyles.subtitle2.copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(7),
        CustomTextFormFieldPassword(
          controller: controller,
          text: "••••••••",
          prefixIcon: const Icon(Icons.lock_outline),
          Text_Color: AppColors.darkColor,
          fill_color: AppColors.backgroundColor,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter your password";
            }
            if (value.length < 6) {
              return "Password must be at least 6 characters";
            }
            return null;
          },
        ),
      ],
    );
  }
}
