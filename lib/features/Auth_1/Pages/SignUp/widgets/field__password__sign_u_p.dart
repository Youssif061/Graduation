import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Field_Password_SignUP extends StatelessWidget {
  const Field_Password_SignUP({super.key, required this.Title});
  final String Title;
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
          text: "••••••••",
          prefixIcon: Icon(Icons.lock_outline),
        ),
      ],
    );
  }
}
