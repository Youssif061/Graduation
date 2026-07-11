import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/App_Email.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Field_Signup extends StatelessWidget {
  const Field_Signup({
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Phone number is required";
            }

            if (!App_Email.isEmailValid(value)) {
              return "Please enter a valid Egyptian phone number";
            }

            return null;
          },
        ),
      ],
    );
  }
}
