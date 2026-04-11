import 'package:flutter/material.dart';

class SupportedLocales {
  static const Locale fallback = Locale('en');

  static const List<Locale> all = [
    Locale('en'),
    Locale('uz'),
    Locale('ru'), 
  ];

  static String nameOf(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'uz':
        return 'Oʻzbekcha';
      case 'ru':
        return 'Русский';
      default:
        return 'Unknown';
    }
  }

  static String flagOf(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'en';
      case 'uz':
        return '🇺🇿';
      case 'ru':
        return '🇷🇺';
      default:
        return '🌐';
    }
  }
}