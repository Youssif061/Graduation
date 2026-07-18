import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field_password.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/widgets/login__with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is AuthNeedEmailVerification) {
          Navigator.pushReplacementNamed(context, Routers.confirmEmail);
        }

        if (state is AuthSuccess) {
          if (state.role == "user") {
            Navigator.pushReplacementNamed(context, Routers.home);
          } else {
            Navigator.pushReplacementNamed(context, Routers.workerHome);
          }
        }
      },

      builder: (context, state) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    style: TextStyle(
                                      fontSize: 12,
                                    ), // تعديل بسيط لضمان حجم النص
                                  ),
                                ],
                              ),
                              const Gap(25),
                              state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : AppButton(
                                      title: "LogIn",
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().login(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          );
                                        }
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
                                ontap: () {
                                  context.read<AuthCubit>().loginWithGoogle();
                                },
                              ),
                              const Gap(15),
                              Login_With(
                                Image: AppImages.Apple,
                                label: "Continue with Apple",
                                ontap: () {
                                  context.read<AuthCubit>().loginWithApple();
                                },
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
                              Navigator.pushNamed(context, Routers.mainSignUp);
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
      },
    );
  }
}
