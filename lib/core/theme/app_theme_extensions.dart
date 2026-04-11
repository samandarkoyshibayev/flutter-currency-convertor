import 'package:currency_converter/core/theme/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_colors_extension.dart';

extension ThemeContextExtension on BuildContext {
  AppColorsExtension get colors => Theme.of(this).extension<AppColorsExtension>()!;
  bool get isDarkMode => watch<ThemeCubit>().state.isDark;
}

extension LocalizationContextExtension on BuildContext {
  String get languageCode => Localizations.localeOf(this).languageCode;
}