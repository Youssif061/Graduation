import 'dart:io';

import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__password__sign_u_p.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Email.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:expertisemarket/features/Auth_1/cubit/cubit_Auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SignUp_for_worker extends StatefulWidget {
  const SignUp_for_worker({super.key});

  @override
  State<SignUp_for_worker> createState() => _SignUp_for_workerState();
}

class _SignUp_for_workerState extends State<SignUp_for_worker> {
  String? path;
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

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
                                                title: const Text("Are you Sure"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() => path = null);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.emeraldColor,
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
                        const Gap(10),
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
                                    if (image != null) {
                                      setState(() {
                                        path = image.path;
                                      });
                                    }
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
                                    if (image != null) {
                                      setState(() {
                                        path = image.path;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Field_Signup(
                          Title: "Full Name",
                          Description: "Enter your full name",
                          icon: Icons.perm_identity_rounded,
                          controller: _nameCtrl,
                        ),
                        Field_Signup(
                          Title: "Email Address",
                          Description: "Enter your email address",
                          icon: Icons.email_outlined,
                          controller: _emailCtrl,
                        ),
                        Field_Signup(
                          Title: "Phone Number",
                          Description: "+02 (01) 0000-00000 ",
                          icon: Icons.add_ic_call,
                          controller: _phoneCtrl,
                        ),
                        Field_Password_SignUP(
                          Title: "Password",
                          controller: _passCtrl,
                        ),
                        Field_Password_SignUP(
                          Title: "Confirm Password",
                          controller: _confirmPassCtrl,
                        ),
                        const Gap(25),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Expanded(child: Divider())],
                        ),

                        const Gap(25),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: "Continue to Step 2",
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) return;
                                  if (_passCtrl.text != _confirmPassCtrl.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Passwords do not match.")),
                                    );
                                    return;
                                  }
                                  auth.signUp(
                                    context: context,
                                    email: _emailCtrl.text,
                                    password: _passCtrl.text,
                                    fullName: _nameCtrl.text,
                                    phone: _phoneCtrl.text,
                                    role: 'worker',
                                  );
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
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(Icons.verified_user),
                        ),
                        Gap(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trust Matters",
                                style: TextStyles.subtitle2.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Gap(10),
                              Text(
                                "Providing accurate information helps us verify your profile faster, allowing you to bid on high-value contracts sooner.",
                                textAlign: TextAlign.left,
                                style: TextStyles.caption1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
