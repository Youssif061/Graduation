import 'dart:io';
import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/confirmEmail.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__password__sign_u_p.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Email.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Phone.dart';
<<<<<<< HEAD
import 'package:expertisemarket/features/Auth_1/Widgets/sign_with_google_or_apple.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_cubit.dart';
import 'package:expertisemarket/features/Auth_1/cubit/auth_state.dart';
=======
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:expertisemarket/features/Auth_1/cubit/cubit_Auth.dart' as auth;
>>>>>>> origin/main
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expertisemarket/core/services/cloudinary_service.dart';

class SignUp_for_user extends StatefulWidget {
  const SignUp_for_user({super.key});

  @override
  State<SignUp_for_user> createState() => _SignUp_for_userState();
}

class _SignUp_for_userState extends State<SignUp_for_user> {
  String? path;
<<<<<<< HEAD
  String imageUrl = '';
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
=======
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
>>>>>>> origin/main
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (state.needEmailVerification) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const confirmEmail()),
            );
          }
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
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
                  key: formKey,
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
                            Text(
                              "Join our network",
                              style: TextStyles.headline.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.securityIconBackgroundColor,
                              ),
                            ),
                            Gap(10),
                            Text(
                              "Let's start with some basic information about you.",
                              style: TextStyles.body.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkGreyColor,
                              ),
                            ),
                            Gap(50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
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
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      child: const Text(
                                                        "Cancel",
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(
                                                          () => path = null,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                      ),
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
=======
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
                        Text(
                          "Join our network",
                          style: TextStyles.headline.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.securityIconBackgroundColor,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "Let's start with some basic information about you.",
                          style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                        const Gap(50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
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
>>>>>>> origin/main
                                        ),
                                      ),
                                  ],
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
                                        var image = await ImagePicker()
                                            .pickImage(
                                              source: ImageSource.camera,
                                            );

                                        if (image == null) return;

                                        setState(() {
                                          path = image.path;
                                        });

                                        imageUrl =
                                            await CloudinaryService.uploadImage(
                                              image.path,
                                            );
                                      },
                                    ),
                                  ),
<<<<<<< HEAD
                                ),

                                const Gap(15),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: AppButton(
                                      title: "Gallery",
                                      backgroundColor: AppColors.primaryColor,
                                      onPressed: () async {
                                        var image = await ImagePicker()
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );

                                        if (image == null) return;

                                        setState(() {
                                          path = image.path;
                                        });

                                        imageUrl =
                                            await CloudinaryService.uploadImage(
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
                              text: "Enter your name",
                              prefixIcon: Icon(Icons.perm_identity_rounded),
                              Text_Styles: AppColors.cardShadowColor,
                              fill_color: AppColors.backgroundColor,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your name";
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
                            ),
                            Field_Password_SignUP(
                              Title: "Confirm Password",
                              controller: confirmPasswordController,
                            ),
                            SignWithGoogleOrApple(
                              onGoogleTap: () {
                                context
                                    .read<AuthCubit>()
                                    .signUpUserWithGoogle();
                              },

                              onAppleTap: () {
                                context.read<AuthCubit>().signUpUserWithApple();
                              },
                            ),
                            Gap(25),
                            Row(
                              children: [
                                Expanded(
                                  child: state is AuthLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : AppButton(
                                          title: "Next",
                                          onPressed: () {
                                            if (!formKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            if (passwordController.text !=
                                                confirmPasswordController
                                                    .text) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Passwords do not match",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            if (imageUrl.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Please select a profile image",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            context
                                                .read<AuthCubit>()
                                                .signUpUser(
                                                  name: nameController.text
                                                      .trim(),
                                                  email: emailController.text
                                                      .trim(),
                                                  phone: phoneController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                  imageUrl: imageUrl,
                                                );
                                          },
                                          backgroundColor:
                                              AppColors.marketGreen,
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
=======
                              ],
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
                        const Gap(25),
                        Text(
                          "Full Name",
                          style: TextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Gap(7),
                        CustomTextFormField(
                          controller: _nameCtrl,
                          text: "Enter your full name",
                          prefixIcon: const Icon(Icons.perm_identity_rounded),
                          Text_Styles: AppColors.cardShadowColor,
                          fill_color: AppColors.backgroundColor,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),

                        Field_Signup(
                          Title: "Email Address",
                          Description: "Enter your email address",
                          icon: Icons.email_outlined,
                          controller: _emailCtrl,
                        ),
                        Field_Signup_Phone(
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
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: "Next",
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
                                    role: 'user',
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
                ],
>>>>>>> origin/main
              ),
            ),
          ),
        );
      },
    );
  }
}
