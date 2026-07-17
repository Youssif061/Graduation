import 'package:dropdown_button2/dropdown_button2.dart';
<<<<<<< HEAD
import 'package:expertisemarket/core/functions/navigations.dart';
=======
>>>>>>> origin/main
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/App_Email.dart';
import 'package:expertisemarket/core/widgets/app_button.dart';
import 'package:expertisemarket/core/widgets/custom_text_form_field.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/SignUp_for_worker/Pages/SignUp_for_worker_3.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/SignUp_for_worker/Widgets/Trust_Matters.dart';
import 'package:expertisemarket/features/Auth_1/cubit/worker_signup_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
=======
>>>>>>> origin/main
import 'package:gap/gap.dart';

class SignUp_for_worker_2 extends StatefulWidget {
  final User? user;

  const SignUp_for_worker_2({super.key, this.user});

  @override
  State<SignUp_for_worker_2> createState() => _SignUp_for_worker_2State();
}

class _SignUp_for_worker_2State extends State<SignUp_for_worker_2> {
  final List<String> items = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'HVAC Specialist',
  ];
  final experienceController = TextEditingController();
  final nationalIdController = TextEditingController();
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
                        Text(
                          "Professional Category",
                          style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(10),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Category',
                              style: TextStyles.body,
                            ),
                            items: items
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item, style: TextStyles.body),
                                  ),
                                )
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Gap(15),
                        Text(
                          "Years of Experience",
                          style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(10),
                        CustomTextFormField(
                          prefixIcon: Icon(
                            Icons.history_edu_outlined,
                            size: 30,
                          ),
                          text: "Enter years of experience",
                          Text_Styles: AppColors.cardShadowColor,
                          fill_color: AppColors.backgroundColor,
                          controller: experienceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter years of experience";
                            }

                            if (int.tryParse(value) == null) {
                              return "Years must be a number";
                            }

                            return null;
                          },
                        ),
                        Gap(25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Expanded(child: Divider())],
                        ),
                        SizedBox(
                          height: 80,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.ContainerColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.badge,
                                    color: AppColors.darkColor,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("National ID ", style: TextStyles.body),
                        Text(
                          "Used to verify your identity and legal right to work.",
                          style: TextStyles.body,
                        ),
                        Gap(25),
                        CustomTextFormField(
                          text: "National ID",
                          Text_Styles: AppColors.cardShadowColor,
                          fill_color: AppColors.backgroundColor,
                          controller: nationalIdController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your National ID";
                            }

                            if (!App_Email.isIDForIdentity(value.trim())) {
                              return "Invalid National ID";
                            }

                            return null;
                          },
                          prefixIcon: Icon(
                            Icons.badge_outlined,
                            size: 30,
                            color: AppColors.darkColor,
                          ),
                        ),
                        Gap(25),

                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: "Continue to Step 3",
                                onPressed: () {
                                  if (selectedValue == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please select your category",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  if (_formKey.currentState!.validate()) {
<<<<<<< HEAD
                                    if (selectedValue == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please choose your profession",
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<WorkerSignupCubit>().saveStep2(
                                      category: selectedValue!,
                                      experience: experienceController.text
                                          .trim(),
                                      nationalId: nationalIdController.text
                                          .trim(),
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
=======
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
>>>>>>> origin/main
                                            const SignUp_for_worker_3(),
                                      ),
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
