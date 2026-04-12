import 'dart:async';

import 'package:currency_converter/app/flavor_config.dart';
import 'package:currency_converter/core/di/injection.dart';
import 'package:currency_converter/core/utils/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'app_bloc_observer.dart';

Future<void> bootstrap({
  required AppFlavor flavor,
  required FlavorConfig config,
}) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _setupSystemUI();
//    await _setupFirebase(config);
      await _setupHive();
      await init();
      Bloc.observer = AppBlocObserver();
//    await _setupRemoteConfig();
//    await _setupNotifications();
      runApp(const App());
    },
    (error, stackTrace) {
      AppLogger.error('Unhandled error', error: error, stackTrace: stackTrace);
       FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          fatal: true,
        );
    },
  );
}

