import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/widgets/custom_svg_picture.dart';
import 'package:expertisemarket/core/widgets/my%20body.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/Pages/Welcome_Screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/ServiceProvider/main/main_app_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      if (!mounted) return;
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();
          final role = doc.data()?['role'] ?? 'user';
          if (mounted) {
            if (role == 'worker') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainAppScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainShell()),
              );
            }
            return;
          }
        } catch (_) {}
      }
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.Splash_Screen,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          MyBodyView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture(path: AppImages.Background),
                  Gap(15),
                  Text(
                    "ExpertiseMarket",
                    style: TextStyles.headline.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  Gap(10),
                  Text(
                    "ELITE PROFESSIONALS , EXCEPTIONAL RESULTS",
                    textAlign: TextAlign.center,
                    style: TextStyles.subtitle1.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  Gap(20),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
