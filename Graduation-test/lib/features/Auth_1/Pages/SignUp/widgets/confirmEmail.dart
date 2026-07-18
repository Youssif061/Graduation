import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class confirmEmail extends StatelessWidget {
  const confirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackgroundColor,
        title: const Text("ExpertiseMarket"),
      ),
      body: MyBodyView(
        child: Center(
          child: Column(
            children: [
              Gap(20),

              Text(
                "Verified Your Email",
                style: TextStyles.title.copyWith(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(30),

              Text(
                "Ceck Your Email and Verified Your Account then return to login",
                style: TextStyles.title.copyWith(color: AppColors.darkColor),
              ),
              Gap(50),
              AppButton(
                title: "Resend Email",

                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!
                      .sendEmailVerification();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
