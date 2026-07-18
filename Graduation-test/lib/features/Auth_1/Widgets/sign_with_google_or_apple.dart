import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/widgets/login__with.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignWithGoogleOrApple extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const SignWithGoogleOrApple({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider()),
            Gap(15),
            Text("OR CONTINUE WITH", style: TextStyle(fontSize: 10)),
            Gap(15),
            Expanded(child: Divider()),
          ],
        ),

        const Gap(15),

        Login_With(
          Image: AppImages.googleSvg,
          label: "Continue with Google",
          ontap: onGoogleTap,
        ),

        const Gap(15),

        Login_With(
          Image: AppImages.Apple,
          label: "Continue with Apple",
          ontap: onAppleTap,
        ),
      ],
    );
  }
}
