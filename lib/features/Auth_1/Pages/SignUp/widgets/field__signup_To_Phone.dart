import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/App_Email.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Field_Signup_Phone extends StatelessWidget {
  const Field_Signup_Phone({
    super.key,
    required this.Title,
    required this.Description,
    required this.icon,
  });

  final String Title;
  final String Description;
  final IconData icon;

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
        CustomTextFormField(
          text: Description,
          prefixIcon: Icon(icon),
          Text_Styles: AppColors.cardShadowColor,
          fill_color: AppColors.backgroundColor,

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter your Phone";
            }

            if (!App_Email.isEgyptianMobile(value.trim())) {
              return "Invalid Phone";
            }

            return null;
          },
        ),
      ],
    );
  }
}
