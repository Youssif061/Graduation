import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_svg_picture.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class Login_With extends StatelessWidget {
  const Login_With({
    super.key,
    required this.Image,
    required this.label,
    required this.ontap,
  });
  final String Image;
  final String label;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accentColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgPicture(path: Image),
            Gap(10),
            Text(label, style: TextStyles.caption1),
          ],
        ),
      ),
    );
  }
}