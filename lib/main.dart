import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_converter/app/app.dart';
import 'package:currency_converter/app/app_bloc_observer.dart';
import 'package:currency_converter/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupSystemUI();
  await Hive.initFlutter();
  await init();
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

Future<void> _setupSystemUI() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
