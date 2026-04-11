import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFF4A90E2);
  static const Color accent = Color(0xFF50C878);

  // Semantic
  static const Color error = Color(0xFFFF6B6B);
  static const Color errorSurface = Color(0xFFFFF0F0);

  // Light surfaces
  static const Color lightBackground = Color(0xFFF8F9FE);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSearchBar = Color(0xFFF0F2F8);

  // Dark surfaces
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF151B3D);
  static const Color darkSearchBar = Color(0xFF1A2042);

  // Text — light
  static const Color textPrimary = Color(0xFF1A1D3D);
  static const Color textSecondary = Color(0xFF6B6F8C);

  // Text — dark
  static const Color darkTextPrimary = Color(0xFFF1F1F1);
  static const Color darkTextSecondary = Color(0xFF8B8FA8);

  // Shared
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color overlay = Color(0x80000000);
}
