import 'package:flutter/material.dart';

class AppThemeColors {
  final bool isDarkMode;

  AppThemeColors({required this.isDarkMode});

  Color get backgroundColor => isDarkMode ? const Color(0xFF0A0E27) : const Color(0xFFF8F9FE);

  Color get cardColor => isDarkMode ? const Color(0xFF151B3D) : Colors.white;

  Color get searchBarColor => isDarkMode ? const Color(0xFF1A2042) : const Color(0xFFF0F2F8);

  Color get textPrimary => isDarkMode ? const Color(0xFFF1F1F1) : const Color(0xFF1A1D3D);

  Color get textSecondary => isDarkMode ? const Color(0xFF8B8FA8) : const Color(0xFF6B6F8C);

  Color get primaryColor => const Color(0xFF4A90E2);

  Color get accentColor => const Color(0xFF50C878);

  Color get errorColor => const Color(0xFFFF6B6B);

  static AppThemeColors of(BuildContext context) {
    return AppThemeColors(
      isDarkMode: Theme.of(context).brightness == Brightness.dark,
    );
  }
}