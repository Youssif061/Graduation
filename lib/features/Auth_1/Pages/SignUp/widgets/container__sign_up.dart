import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Container_SignUp extends StatelessWidget {
  const Container_SignUp({
    super.key,
    required this.BigIcon,
    required this.Description,
    required this.image,
    required this.SmallIcon,
    required this.Text_for_button,
    required this.Title,
    required this.ontap,
  });

  final IconData BigIcon;
  final IconData SmallIcon;
  final String Title;
  final String Description;
  final String Text_for_button;
  final String image;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.inputBorderColor, blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    BigIcon,
                    size: 90,
                    color: AppColors.darkColor.withValues(alpha: 0.12),
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 0,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: AppColors.ContainerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(SmallIcon, color: Colors.white, size: 28),
                  ),
                ),
              ],
            ),
          ),
          Text(
            Title,
            style: TextStyles.subtitle1.copyWith(fontWeight: FontWeight.w600),
          ),
          Gap(10),
          Text(
            Description,
            textAlign: TextAlign.left,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w300),
          ),
          Gap(15),
          GestureDetector(
            onTap: ontap,
            child: Row(
              children: [
                Text(
                  Text_for_button,
                  style: TextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.emeraldColor,
                  ),
                ),
                Icon(Icons.arrow_forward, color: AppColors.emeraldColor),
              ],
            ),
          ),
          Gap(20),
          Column(
            children: [
              Image.asset(image, height: 160, width: 290, fit: BoxFit.fitWidth),
            ],
          ),
        ],
      ),
    );
  }
}
