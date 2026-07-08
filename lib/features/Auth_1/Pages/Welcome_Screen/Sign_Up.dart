import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Sign_up extends StatelessWidget {
  const Sign_up({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        automaticallyImplyLeading: false,
        title: Text(
          "ExpertiseMarket",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),

      body: MyBodyView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Welcome to Excellence",
                style: TextStyles.headline.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(15),
              Text(
                "Choose your path in our premium market place. Are you looking for top-tier expertise or ready to offer your professional services?",
                textAlign: TextAlign.center,
                style: TextStyles.subtitle1.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(45),
              Container(
                height: 500,
                width: 360,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.passwordDotsColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(AppImages.Client_Card, fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
