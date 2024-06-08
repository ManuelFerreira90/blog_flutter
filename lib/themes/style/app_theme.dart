import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ThemeColors.colorScaffold,
        dividerColor: ThemeColors.colorDiviser,
  );
}