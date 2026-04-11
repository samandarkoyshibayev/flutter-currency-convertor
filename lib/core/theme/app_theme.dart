import 'package:flutter/material.dart';
import 'app_colors_extension.dart';

abstract class AppTheme {
  // Shared Colors
  static const Color _primary = Color(0xFF4A90E2);
  static const Color _accent = Color(0xFF50C878);
  static const Color _error = Color(0xFFFF6B6B);

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFF8F9FE);
  static const Color _lightCard = Color(0xFFFFFFFF);
  static const Color _lightSearchBar = Color(0xFFF0F2F8);
  static const Color _lightTextPrimary = Color(0xFF1A1D3D);
  static const Color _lightTextSecondary = Color(0xFF6B6F8C);

  // Dark Theme Colors
  static const Color _darkBackground = Color(0xFF0A0E27);
  static const Color _darkCard = Color(0xFF151B3D);
  static const Color _darkSearchBar = Color(0xFF1A2042);
  static const Color _darkTextPrimary = Color(0xFFF1F1F1);
  static const Color _darkTextSecondary = Color(0xFF8B8FA8);

  // LIGHT THEME
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBackground,
      colorScheme: const ColorScheme.light(
        primary: _primary,
        error: _error,
        surface: _lightBackground,
      ),
      extensions: const [
        AppColorsExtension(
          backgroundColor: _lightBackground,
          cardColor: _lightCard,
          searchBarColor: _lightSearchBar,
          textPrimary: _lightTextPrimary,
          textSecondary: _lightTextSecondary,
          primaryColor: _primary,
          accentColor: _accent,
          errorColor: _error,
        ),
      ],
    );
  }

  // DARK THEME
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        error: _error,
        surface: _darkBackground,
      ),
      extensions: const [
        AppColorsExtension(
          backgroundColor: _darkBackground,
          cardColor: _darkCard,
          searchBarColor: _darkSearchBar,
          textPrimary: _darkTextPrimary,
          textSecondary: _darkTextSecondary,
          primaryColor: _primary,
          accentColor: _accent,
          errorColor: _error,
        ),
      ],
    );
  }
}