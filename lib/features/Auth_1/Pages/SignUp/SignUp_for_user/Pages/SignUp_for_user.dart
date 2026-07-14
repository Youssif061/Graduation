import 'dart:io';

import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/functions/navigations.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__password__sign_u_p.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Email.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/field__signup_To_Phone.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SignUp_for_user extends StatefulWidget {
  const SignUp_for_user({super.key});

  @override
  State<SignUp_for_user> createState() => _SignUp_for_userState();
}

class _SignUp_for_userState extends State<SignUp_for_user> {
  String? path;
  TextEditingController controller = TextEditingController();
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
                                    child: CircleAvatar(
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
                        prefixIcon: Icon(Icons.perm_identity_rounded),
                        Text_Styles: AppColors.cardShadowColor,
                        fill_color: AppColors.backgroundColor,
                      ),

                      Field_Signup(
                        Title: "Email Address",
                        Description: "Enter your email address",
                        icon: Icons.email_outlined,
                      ),
                      Field_Signup_Phone(
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
