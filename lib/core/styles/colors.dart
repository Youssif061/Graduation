import 'package:flutter/material.dart';

abstract class AppColors {
  // Team Colors
  static const Color primaryColor = Color(0xFF2ECC71);
  static const Color secondaryColor = Color(0xFF006D37);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF94A3B8);
  static const Color borderColor = Color(0xFF94A3B8);
  static const Color greyColor = Color(0xFF74777D);
  static const Color darkGreyColor = Color(0xFF43474D);
  static const Color darkColor = Color(0xFF141D23);
  static const Color errorColor = Color(0xFF9F1717);

  // Change Password
  static const Color navyColor = Color(0xFF03192E);
  static const Color emeraldColor = Color(0xFF006D37);

  static const Color lightBackgroundColor = Color(0xFFF6FAFF);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  static const Color textPrimaryColor = Color(0xFF141D23);
  static const Color textSecondaryColor = Color(0xFF43474D);
  static const Color textMutedColor = Color(0xFF74777D);

  static const Color inputBorderColor = Color(0xFFC4C6CD);
  static const Color inputFocusedBorderColor = Color(0xFF03192E);

  static const Color passwordDotsColor = Color(0xFFC4C6CD);
  static const Color strengthTrackColor = Color(0xFFD2DBE4);

  static const Color securityIconBackgroundColor = Color(0xFF1A2E44);

  static const Color cardShadowColor = Color(0x1A03192E);
  static const Color buttonShadowColor = Color(0x2E03192E);
  static const Color ContainerColor = Color(0xFF00C3D0);

  // ─── Market (Light Theme - Figma) ───────────────────────────────
  static const Color marketBg = Color(0xFFF4F6F8);
  static const Color marketCard = Color(0xFFFFFFFF);
  static const Color marketCardLight = Color(0xFFF8FAFC);
  static const Color marketGreen = Color(0xFF00B074); // Vibrant green accent
  static const Color marketGreenDark = Color(
    0xFF00875A,
  ); // Darker green for price/verified text
  static const Color marketGreenBadge = Color(
    0xFFE6F7F0,
  ); // Light green bg for badges
  static const Color marketText = Color(0xFF0F172A); // Dark slate primary text
  static const Color marketTextSub = Color(
    0xFF475569,
  ); // Slate-600 description / secondary text
  static const Color marketTextMuted = Color(
    0xFF94A3B8,
  ); // Slate-400 helper text
  static const Color marketRed = Color(0xFFEF4444); // Error/delete/red badge
  static const Color marketYellow = Color(0xFFF59E0B); // Amber stars rating
  static const Color marketBorder = Color(0xFFE2E8F0); // Thin grey border
  static const Color marketInputBg = Color(
    0xFFF0F3F6,
  ); // Grey/blue search bar bg
  static const Color marketDivider = Color(0xFFE2E8F0); // Grey divider

  // ─── Bottom Nav ────────────────────────────────────────────────
  static const Color navBg = Color(0xFFFFFFFF);
  static const Color navActive = Color(0xFF00B074);
  static const Color navInactive = Color(0xFF94A3B8);
  static const Color navActiveBg =
      Colors.transparent; // Disabled active pill background as per mockup
}
