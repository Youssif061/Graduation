import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

abstract class TextStyles {
  static const TextStyle headline = TextStyle(fontSize: 30);
  static const TextStyle title = TextStyle(fontSize: 24);
  static const TextStyle subtitle1 = TextStyle(fontSize: 20);
  static const TextStyle subtitle2 = TextStyle(fontSize: 18);
  static const TextStyle body = TextStyle(fontSize: 16);
  static const TextStyle caption1 = TextStyle(fontSize: 14);
  static const TextStyle caption2 = TextStyle(fontSize: 12);
}

abstract class ExpertiseTextStyles {
  static TextStyle get screenTitle => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.navyColor,
  );

  static TextStyle get sectionTitle => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.navyColor,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textSecondaryColor,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.surfaceColor,
  );

  static TextStyle get helper => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.4,
    color: AppColors.textMutedColor,
  );

  static TextStyle get inputText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle get inputHint => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textMutedColor,
  );

  static TextStyle get error => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.errorColor,
  );
}