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

// ─── Market Text Styles (Dark Theme) ──────────────────────────────────────────
abstract class MarketTextStyles {
  static TextStyle get appBarTitle => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.marketText,
    letterSpacing: 0.2,
  );

  static TextStyle get sectionTitle => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.marketText,
  );

  static TextStyle get productTitle => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.marketText,
    height: 1.4,
  );

  static TextStyle get productTitleLarge => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.marketText,
    height: 1.4,
  );

  static TextStyle get price => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.marketGreen,
  );

  static TextStyle get priceLarge => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.marketGreen,
  );

  static TextStyle get priceStrike => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.marketTextMuted,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.marketTextSub,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.marketTextSub,
    height: 1.6,
  );

  static TextStyle get badge => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.marketGreen,
    letterSpacing: 0.5,
  );

  static TextStyle get chipLabel => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.marketText,
  );

  static TextStyle get chipLabelInactive => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.marketTextSub,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.marketText,
  );

  static TextStyle get buttonTextGreen => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle get tabLabel => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.marketTextSub,
  );

  static TextStyle get rating => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.marketTextSub,
  );

  static TextStyle get sectionLabel => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.marketTextMuted,
    letterSpacing: 1.0,
  );

  static TextStyle get specKey => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.marketTextMuted,
  );

  static TextStyle get specValue => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.marketText,
  );

  static TextStyle get totalLabel => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.marketTextSub,
  );

  static TextStyle get totalValue => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.marketText,
  );

  static TextStyle get grandTotal => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.marketText,
  );

  static TextStyle get successTitle => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF141D23),
  );

  static TextStyle get successBody => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF64748B),
    height: 1.5,
    textStyle: const TextStyle(color: Color(0xFF64748B)),
  );
}
