  import 'package:flutter/material.dart';

  abstract class AppTextStyles {
    static const String _fontFamily = 'Inter';

    // Display
    static const TextStyle displayLg = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -1.5,
    );
    static const TextStyle displayMd = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -1.0,
    );
    static const TextStyle displaySm = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -0.5,
    );

    // Headings
    static const TextStyle h1 = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );
    static const TextStyle h2 = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.35,
    );
    static const TextStyle h3 = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
    static const TextStyle h4 = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );

    // Body
    static const TextStyle bodyLg = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
    );
    static const TextStyle bodyMd = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.6,
    );
    static const TextStyle bodySm = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );

    // Label / Caption
    static const TextStyle labelLg = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
    static const TextStyle labelMd = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
    static const TextStyle labelSm = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
    static const TextStyle caption = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 0.3,
    );

    // Button
    static const TextStyle buttonLg = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.0,
    );
    static const TextStyle buttonMd = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.0,
    );
    static const TextStyle buttonSm = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.0,
    );
  }
