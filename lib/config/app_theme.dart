import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/app_colors.dart';

class AppTheme {
  static ThemeData appLightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        titleSpacing: 20,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      hintColor: AppColors.hintColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
        ),
        bodySmall: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
