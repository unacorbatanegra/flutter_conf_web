import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';

class AppTheme {
  static final appThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    useMaterial3: true,
  );
}
