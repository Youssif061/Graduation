import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/functions/navigations.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_svg_picture.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/Welcome_Screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      PushReplacement(context, Welcome_Screen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.Splash_Screen,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          MyBodyView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture(path: AppImages.Background),
                  Gap(15),
                  Text(
                    "ExpertiseMarket",
                    style: TextStyles.headline.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  Gap(10),
                  Text(
                    "ELITE PROFESSIONALS , EXCEPTIONAL RESULTS",
                    textAlign: TextAlign.center,
                    style: TextStyles.subtitle1.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  Gap(20),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
