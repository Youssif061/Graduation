import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Welcome_Screen extends StatelessWidget {
  const Welcome_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strengthTrackColor,
      body: MyBodyView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(85),
              Text(
                "ExpertiseMarket",
                style: TextStyles.headline.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gap(10),

              Text(
                "Welcome back",
                style: TextStyles.title.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                "Access your professional marketplace dashboard",
                textAlign: TextAlign.center,
                style: TextStyles.subtitle1,
              ),
              Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.navyColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address"),
                      Gap(10),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email),
                        text: "name@company.com",
                      ),
                      Gap(20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Password"),
                          TextButton(
                            onPressed: () {},
                            child: Text("Forgot Password?"),
                          ),
                        ],
                      ),
                      CustomTextFormFieldPassword(
                        prefixIcon: Image.asset(
                          AppImages.Container,
                          width: 20,
                          height: 20,
                        ),
                        text: "••••••••••••••••",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
