import 'package:expertisemarket/core/constants/app_fonts.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class Appthem {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: AppColors.greyColor,
    fontFamily: AppFont.OpenSans,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.greyColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        minimumSize: Size(60, 20),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.greyColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      selectedLabelStyle: TextStyles.subtitle1.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.8,
      ),
      unselectedLabelStyle: TextStyles.subtitle2.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.8,
      ),
    ),
  );
}
