import 'package:currency_converter/core/localization/supported_locales.dart';
import 'package:currency_converter/core/storage/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/storage_constants.dart';
import 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(this._storage) : super(LocalizationState(locale: SupportedLocales.fallback));

  final LocalStorage _storage;

  Future<void> loadLocale() async {
    final saved = _storage.read<String>(StorageKeys.languageCode);
    final locale = saved != null ? Locale(saved) : SupportedLocales.fallback;
    
    emit(LocalizationState(locale: locale));
  }

  Future<void> changeLocale(Locale locale) async {
    await _storage.write(StorageKeys.languageCode, locale.languageCode);
    emit(LocalizationState(locale: locale));
  }
}