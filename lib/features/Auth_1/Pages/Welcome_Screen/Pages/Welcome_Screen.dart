import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/Main_SignUp.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/widgets/login__with.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Welcome_Screen extends StatefulWidget {
  const Welcome_Screen({super.key});

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen> {
  bool stayLogged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strengthTrackColor,
      body: MyBodyView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(60),
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
                  height: 595,
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
                          prefixIcon: Icon(Icons.lock),
                          text: "••••••••••••",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Gap(25),

                        Row(
                          children: [
                            Checkbox(
                              value: stayLogged,
                              activeColor: const Color(0xFF2ECC71),
                              onChanged: (bool? value) {
                                setState(() {
                                  stayLogged = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "Stay logged in for 30 days",
                              style: TextStyles.caption1,
                            ),
                          ],
                        ),
                        Gap(25),
                        AppButton(
                          title: "LogIn",
                          onPressed: () {},
                          backgroundColor: AppColors.primaryColor,
                        ),
                        Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Divider()),
                            Gap(15),
                            Text(
                              "OR CONTINUE WITH",
                              style: TextStyles.caption1,
                            ),
                            Gap(15),

                            Expanded(child: Divider()),
                          ],
                        ),
                        Gap(15),
                        Login_With(
                          Image: AppImages.googleSvg,
                          label: "Continue with Google",
                          ontap: () {},
                        ),
                        Gap(15),
                        Login_With(
                          Image: AppImages.Apple,
                          label: "Continue with Apple",
                          ontap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Sign_up()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: AppColors.emeraldColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
