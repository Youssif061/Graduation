import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/functions/navigations.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/my body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/SignUp_for_user/Pages/SignUp_for_user.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/SignUp_for_worker/Pages/SignUp_for_worker_1.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/container__sign_up.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Sign_up extends StatelessWidget {
  const Sign_up({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "ExpertiseMarket",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: MyBodyView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ExpertiseMarket",
                  style: TextStyles.title.copyWith(fontWeight: FontWeight.w800),
                ),
                const Gap(30),

                Container_SignUp(
                  BigIcon: Icons.search,
                  SmallIcon: Icons.search,
                  Title: "I Need a Service",
                  Description:
                      "Access a curated network of vetted experts across technology , design , and business strategy.",
                  Text_for_button: "Start As a User",
                  image: AppImages.Border,
                  ontap: () {
                    pushTo(context, const SignUp_for_user());
                  },
                ),
                Gap(35),
                Container_SignUp(
                  BigIcon: Icons.work_outline_rounded,
                  Description:
                      "Join our elite collective of specialists. Grow your business with high-value contracts and secure tools.",
                  image: AppImages.Border_For_Offer,
                  SmallIcon: Icons.work_outline_rounded,
                  Text_for_button: "Start As a Worker",
                  Title: "I Offer Services",
                  ontap: () {
                    pushTo(context, const SignUp_for_worker_1());
                   
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
