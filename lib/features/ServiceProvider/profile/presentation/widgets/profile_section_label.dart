import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileSectionLabel extends StatelessWidget {
  const ProfileSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MarketTextStyles.sectionLabel.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
      ),
    );
  }
}
