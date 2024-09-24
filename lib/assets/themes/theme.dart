import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

abstract class AppTheme {
  static ThemeData theme() => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'VelaSans',
        highlightColor: AppColors.white,
        primaryColor: AppColors.yellow,
        primaryColorLight: AppColors.white,
        primaryColorDark: AppColors.yellow,
        hintColor: AppColors.grey2,
        disabledColor: AppColors.grey2,
        iconTheme: const IconThemeData(color: AppColors.grey1),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          refreshBackgroundColor: AppColors.white,
          color: AppColors.orange,
          circularTrackColor: AppColors.orange,
          linearTrackColor: AppColors.orange,
        ),
        dividerTheme: const DividerThemeData(color: AppColors.grey4),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: AppColors.black,
            unselectedItemColor: AppColors.grey2,
            selectedLabelStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 11),
            unselectedLabelStyle: TextStyle(color: AppColors.grey2, fontWeight: FontWeight.w400, fontSize: 11),
            selectedIconTheme: IconThemeData(color: AppColors.black),
            unselectedIconTheme: IconThemeData(color: AppColors.black)),
        dividerColor: AppColors.black,
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.black),
          titleTextStyle: displayMedium.copyWith(color: AppColors.black),
          centerTitle: true,
          backgroundColor: AppColors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Platform.isIOS ? AppColors.black : AppColors.white,
              statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
              statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
              // systemNavigationBarColor: Platform.isIOS ? AppColors.mainDark : AppColors.white,
              systemNavigationBarIconBrightness: Brightness.dark),
        ),
        cardTheme: const CardTheme(color: AppColors.black),
        drawerTheme: const DrawerThemeData(
            backgroundColor: AppColors.black,
            scrimColor: AppColors.black,
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.black),
        // floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: buttonGreenColor),
        textTheme: const TextTheme(
            displayLarge: displayLarge,
            displayMedium: displayMedium,
            displaySmall: displaySmall,
            headlineLarge: headlineLarge,
            headlineMedium: headlineMedium,
            headlineSmall: headlineSmall,
            titleLarge: titleLarge,
            titleMedium: titleMedium,
            titleSmall: titleSmall,
            bodyLarge: bodyLarge,
            bodyMedium: bodyMedium,
            bodySmall: bodySmall,
            labelLarge: labelLarge,
            labelMedium: labelMedium,
            labelSmall: labelSmall),
      );

  // Fonts
  static const displayLarge =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: 0.1);
  static const displayMedium =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const displaySmall =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const headlineLarge =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const headlineMedium =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.black, letterSpacing: 0.1);
  static const headlineSmall =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.black, letterSpacing: 0.1);
  static const titleLarge =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const titleMedium =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const titleSmall =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.black, letterSpacing: 0.1);
  static const bodyLarge =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black, letterSpacing: 0.1);
  static const bodyMedium =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.1);
  static const bodySmall =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black, letterSpacing: 0.1);
  static const labelLarge =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: 0.1);
  static const labelMedium =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, letterSpacing: 0.1);
  static const labelSmall =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.black, letterSpacing: 0.1);
}
