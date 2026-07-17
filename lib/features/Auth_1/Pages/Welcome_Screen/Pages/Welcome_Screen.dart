import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/Main_SignUp.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/widgets/login__with.dart';
import 'package:expertisemarket/features/Auth_1/Widgets/sign_with_google_or_apple.dart';
import 'package:expertisemarket/features/Auth_1/cubit/cubit_Auth.dart';
import 'package:expertisemarket/features/ServiceProvider/home/page/home_screen.dart';
import 'package:expertisemarket/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_state.dart';

// تعديل اسم الكلاس لاتباع معايير Dart (UpperCamelCase)
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
<<<<<<< HEAD
  State<WelcomeScreen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<WelcomeScreen> {
=======
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
>>>>>>> origin/main
  final _formKey = GlobalKey<FormState>();
  bool stayLogged = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strengthTrackColor,
      body: MyBodyView(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(60),
                  Text(
                    "ExpertiseMarket",
                    style: TextStyles.headline.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap(10),

                  Text(
                    "Welcome back",
                    style: TextStyles.title.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Access your professional marketplace dashboard",
                    textAlign: TextAlign.center,
                    style: TextStyles.subtitle1,
                  ),
                  const Gap(20), // أضفت مسافة صغيرة لتنسيق التصميم
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
                          const Text("Email Address"),

                          Gap(10),

                          CustomTextFormField(
                            prefixIcon: const Icon(Icons.email),
                            text: "name@company.com",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your email";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Password"),
                              TextButton(
                                onPressed: () {},
                                child: const Text("Forgot Password?"),
                              ),
                            ],
                          ),
                          CustomTextFormFieldPassword(
                            prefixIcon: const Icon(Icons.lock),
                            text: "••••••••••••",
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const Gap(25),
                          Row(
                            children: [
                              Checkbox(
                                value: stayLogged,
                                activeColor: AppColors.marketGreen,
                                onChanged: (bool? value) {
                                  setState(() {
                                    stayLogged = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                "Stay logged in for 30 days",
<<<<<<< HEAD
                                style: TextStyle(
                                  fontSize: 12,
                                ), // تعديل بسيط لضمان حجم النص
=======
                                style: TextStyle(fontSize: 12), // تعديل بسيط لضمان حجم النص
>>>>>>> origin/main
                              ),
                            ],
                          ),
                          const Gap(25),
                          AppButton(
                            title: "LogIn",
                            onPressed: () async {
                              // تأكد من أن دالة login مستوردة أو معرفة لديك بشكل صحيح
                              await login(
                                _formKey,
                                context,
                                emailController,
                                passwordController,
                              );
                            },
                            backgroundColor: AppColors.primaryColor,
                          ),
                          const Gap(15),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Divider()),
                              Gap(15),
                              Text(
                                "OR CONTINUE WITH",
                                style: TextStyle(fontSize: 10),
                              ),
                              Gap(15),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const Gap(15),
                          Login_With(
                            Image: AppImages.googleSvg,
                            label: "Continue with Google",
<<<<<<< HEAD
                            ontap:
                                () {}, 
=======
                            ontap: () {}, // تم إبقاء اسم الخاصية كما هو معرف في الـ Widget لديك
>>>>>>> origin/main
                          ),
                          const Gap(15),
                          Login_With(
                            Image: AppImages.Apple,
                            label: "Continue with Apple",
                            ontap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Sign_up()),
                          );
                        },
                        child: const Text(
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
      ),
    );
  }
}