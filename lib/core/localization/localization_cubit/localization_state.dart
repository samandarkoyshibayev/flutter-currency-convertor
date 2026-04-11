import 'package:currency_converter/core/localization/supported_locales.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class LocalizationState extends Equatable {
  const LocalizationState({required this.locale});

  final Locale locale;

  String get languageCode => locale.languageCode;
  String get name => SupportedLocales.nameOf(locale);
  String get flag => SupportedLocales.flagOf(locale);

  LocalizationState copyWith({Locale? locale}) => LocalizationState(locale: locale ?? this.locale);

  @override
  List<Object> get props => [locale];
}