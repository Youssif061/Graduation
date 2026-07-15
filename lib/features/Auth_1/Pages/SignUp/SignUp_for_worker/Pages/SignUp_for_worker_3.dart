import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/Auth_1/Pages/SignUp/widgets/getCurrentLocation.dart';
import 'package:flutter/material.dart';

class SignUp_for_worker_3 extends StatefulWidget {
  const SignUp_for_worker_3({super.key});

  @override
  State<SignUp_for_worker_3> createState() => _SignUp_for_worker_2();
}

class _SignUp_for_worker_2 extends State<SignUp_for_worker_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackgroundColor,
        title: const Text("ExpertiseMarket"),
      ),
      body: MapScreen(),
    );
  }
}
