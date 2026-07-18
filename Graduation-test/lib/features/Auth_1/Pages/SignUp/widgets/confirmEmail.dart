import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              Text("Verified Your Email", style: TextStyles.title),
              Text(
                "Ceck Your Email and Verified Your Account ",
                style: TextStyles.title,
              ),
              Icon(Icons.verified),
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
