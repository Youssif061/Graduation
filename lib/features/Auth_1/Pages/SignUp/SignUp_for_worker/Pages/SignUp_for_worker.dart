import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/functions/navigations.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__password__sign_u_p.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUp_for_worker extends StatelessWidget {
  const SignUp_for_worker({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 360,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              AppImages.Border,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      Field_Signup(
                        Title: "Full Name",
                        Description: "Enter your full name",
                        icon: Icons.perm_identity_rounded,
                      ),
                      Field_Signup(
                        Title: "Phone Number",
                        Description: "Enter your email address",
                        icon: Icons.email_outlined,
                      ),
                      Field_Signup(
                        Title: "Phone Number",
                        Description: "+02 (01) 0000-00000 ",
                        icon: Icons.add_ic_call,
                      ),
                      Field_Password_SignUP(Title: "Password"),
                      Field_Password_SignUP(Title: "Confirm Password"),

                      Gap(25),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: "Next",
                              onPressed: () {
                                pushTo(context, const MainShell());
                              },
                              backgroundColor: AppColors.marketGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
