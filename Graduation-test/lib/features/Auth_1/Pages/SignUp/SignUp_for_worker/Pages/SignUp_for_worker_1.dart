import 'dart:io';
import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/SignUp_for_worker/Widgets/Trust_Matters.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__password__sign_u_p.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Email.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Phone.dart';
import 'package:expertisemarket/features/Auth_1/Widgets/sign_with_google_or_apple.dart';
import 'package:expertisemarket/features/Auth_1/cubit/worker_signup_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/worker_signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_state.dart';
import 'package:expertisemarket/core/routes/routers.dart';

class SignUp_for_worker_1 extends StatefulWidget {
  const SignUp_for_worker_1({super.key});

  @override
  State<SignUp_for_worker_1> createState() => _SignUp_for_worker_1State();
}

class _SignUp_for_worker_1State extends State<SignUp_for_worker_1> {
  String? path;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
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
            child: Form(
              key: _formKey,
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
                            Center(
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: path != null
                                        ? Image.file(
                                            File(path!),
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            AppImages.User,
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  if (path != null)
                                    Positioned(
                                      right: 5,
                                      bottom: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: Text("Are you Sure"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        path = null;
                                                      });

                                                      context
                                                          .read<
                                                            WorkerSignupCubit
                                                          >()
                                                          .saveImage('');

                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              AppColors.emeraldColor,
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: AppButton(
                                  title: "Camera",
                                  backgroundColor: AppColors.primaryColor,
                                  onPressed: () async {
                                    var image = await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                    );

                                    if (image == null) return;

                                    setState(() {
                                      path = image.path;
                                    });
                                    context.read<WorkerSignupCubit>().saveImage(
                                      image.path,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Gap(15),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: AppButton(
                                  title: "Gallery",
                                  backgroundColor: AppColors.primaryColor,
                                  onPressed: () async {
                                    var image = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (image == null) return;

                                    setState(() {
                                      path = image.path;
                                    });

                                    context.read<WorkerSignupCubit>().saveImage(
                                      image.path,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Text(
                          "Full Name",
                          style: TextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Gap(7),
                        CustomTextFormField(
                          text: "Enter your full name",
                          controller: nameController,
                          prefixIcon: Icon(Icons.perm_identity_rounded),
                          Text_Styles: AppColors.cardShadowColor,
                          fill_color: AppColors.backgroundColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Name";
                            }
                            return null;
                          },
                        ),

                        Field_Signup(
                          Title: "Email Address",
                          Description: "Enter your email address",
                          icon: Icons.email_outlined,
                          controller: emailController,
                        ),
                        Field_Signup_Phone(
                          Title: "Phone Number",
                          Description: "+02 (01) 0000-00000 ",
                          icon: Icons.add_ic_call,
                          controller: phoneController,
                        ),
                        Field_Password_SignUP(
                          Title: "Password",
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please your password";
                            }
                            return null;
                          },
                        ),
                        Field_Password_SignUP(
                          Title: "Confirm Password",
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }

                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),
                        Gap(25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Expanded(child: Divider())],
                        ),
                        SignWithGoogleOrApple(
                          onGoogleTap: () async {
                            final user = await context
                                .read<AuthCubit>()
                                .signUpWorkerWithGoogle();

                            if (user == null) return;

                            context.read<WorkerSignupCubit>().saveStep1(
                              name: user.displayName ?? '',
                              email: user.email ?? '',
                              phone: '',
                              password: '',
                              uid: user.uid,
                            );
                            context.read<WorkerSignupCubit>().saveUid(user.uid);
                            context.read<WorkerSignupCubit>().saveImage(
                              user.photoURL ?? '',
                            );
                            context.read<WorkerSignupCubit>().saveSignupMethod(
                              SignupMethod.google,
                            );
                            Navigator.pushNamed(context, Routers.workerSignUp2);
                          },

                          onAppleTap: () async {
                            final user = await context
                                .read<AuthCubit>()
                                .signUpWorkerWithApple();

                            if (user == null) return;

                            context.read<WorkerSignupCubit>().saveStep1(
                              name: user.displayName ?? '',
                              email: user.email ?? '',
                              phone: '',
                              password: '',
                              uid: user.uid,
                            );
                            context.read<WorkerSignupCubit>().saveUid(user.uid);
                            context.read<WorkerSignupCubit>().saveImage(
                              user.photoURL ?? '',
                            );
                            context.read<WorkerSignupCubit>().saveSignupMethod(
                              SignupMethod.apple,
                            );
                            Navigator.pushNamed(context, Routers.workerSignUp2);
                          },
                        ),
                        Gap(25),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: "Continue to Step 2",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final workerCubit = context
                                        .read<WorkerSignupCubit>();

                                    if (workerCubit.state.imagePath.isEmpty &&
                                        workerCubit.state.signupMethod ==
                                            SignupMethod.email) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please upload your profile image",
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    workerCubit.saveStep1(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    workerCubit.saveSignupMethod(
                                      SignupMethod.email,
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      Routers.workerSignUp2,
                                    );
                                  }
                                },
                                backgroundColor: AppColors.marketGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(25),
                  Trust_Matters(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
