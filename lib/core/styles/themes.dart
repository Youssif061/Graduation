import 'package:expertisemarket/core/constants/app_fonts.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class Appthem {
  const Appthem._();

  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.marketGreen,
      secondary: AppColors.marketGreenDark,
      surface: AppColors.marketCard,
      onSurface: AppColors.marketText,
      error: AppColors.marketRed,
      outline: AppColors.marketBorder,
      outlineVariant: AppColors.marketBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFont.OpenSans,
      scaffoldBackgroundColor: AppColors.marketBg,
      colorScheme: colorScheme,
      dividerColor: AppColors.marketDivider,
      appBarTheme: const AppBarThemeData(
        backgroundColor: AppColors.marketCard,
        foregroundColor: AppColors.marketText,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navBg,
        selectedItemColor: AppColors.navActive,
        unselectedItemColor: AppColors.navInactive,
      ),
    );
  }

  static ThemeData get dark {
    const darkBackground = Color(0xFF0F172A);
    const darkSurface = Color(0xFF1E293B);
    const darkSurfaceVariant = Color(0xFF263449);
    const darkBorder = Color(0xFF334155);
    const darkText = Color(0xFFF8FAFC);
    const darkTextSecondary = Color(0xFFCBD5E1);

    const colorScheme = ColorScheme.dark(
      primary: AppColors.marketGreen,
      secondary: Color(0xFF34D399),
      surface: darkSurface,
      onSurface: darkText,
      error: Color(0xFFF87171),
      outline: darkBorder,
      outlineVariant: darkBorder,
      surfaceContainerHighest: darkSurfaceVariant,
      onSurfaceVariant: darkTextSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFont.OpenSans,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: colorScheme,
      dividerColor: darkBorder,
      appBarTheme: const AppBarThemeData(
        backgroundColor: darkSurface,
        foregroundColor: darkText,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkSurface,
        selectedItemColor: AppColors.marketGreen,
        unselectedItemColor: darkTextSecondary,
      ),
    );
  }
}
