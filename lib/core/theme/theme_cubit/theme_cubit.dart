import 'package:currency_converter/core/storage/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/storage_constants.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._storage) : super(const ThemeState(themeMode: ThemeMode.system));

  final LocalStorage _storage;

  Future<void> loadTheme() async {
    final saved = _storage.read<String>(StorageKeys.themeMode);
    final mode = _themeModeFromString(saved);
    emit(ThemeState(themeMode: mode));
  }
  Future<void> setLight() => _setTheme(ThemeMode.light);
  Future<void> setDark() => _setTheme(ThemeMode.dark);
  Future<void> setSystem() => _setTheme(ThemeMode.system);

  void toggle() {
    final next = state.isDark ? ThemeMode.light : ThemeMode.dark;
    _setTheme(next);
  }

  Future<void> _setTheme(ThemeMode mode) async {
    await _storage.write(StorageKeys.themeMode, mode.name);
    emit(ThemeState(themeMode: mode));
  }
  ThemeMode _themeModeFromString(String? value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
