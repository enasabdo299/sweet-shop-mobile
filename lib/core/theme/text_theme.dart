import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
    displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
  );
}
