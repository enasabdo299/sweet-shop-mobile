import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.accentColor,
    scaffoldBackgroundColor: AppColors.backgroundColor, // ✅ تم التعديل هنا
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      height: 50.0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
    ),
  );
}
