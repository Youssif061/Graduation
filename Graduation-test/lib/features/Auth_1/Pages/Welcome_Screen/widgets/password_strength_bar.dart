import 'package:flutter/material.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/text_styles.dart';

class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({super.key, required this.password});

  final String password;

  double get _strengthValue {
    if (password.isEmpty) return 0;

    int score = 0;

    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    return score / 4;
  }

  String get _strengthLabel {
    if (password.isEmpty) return 'STRENGTH';
    if (_strengthValue <= 0.25) return 'WEAK';
    if (_strengthValue <= 0.75) return 'MEDIUM';
    return 'STRONG';
  }

  Color get _strengthColor {
    if (password.isEmpty) return AppColors.strengthTrackColor;
    if (_strengthValue <= 0.25) return AppColors.errorColor;
    if (_strengthValue <= 0.75) return AppColors.navyColor;
    return AppColors.emeraldColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            child: SizedBox(
              height: 4,
              child: Stack(
                children: [
                  Container(color: AppColors.strengthTrackColor),
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    widthFactor: _strengthValue,
                    alignment: Alignment.centerLeft,
                    child: Container(color: _strengthColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          _strengthLabel,
          style: ExpertiseTextStyles.helper.copyWith(color: _strengthColor),
        ),
      ],
    );
  }
}