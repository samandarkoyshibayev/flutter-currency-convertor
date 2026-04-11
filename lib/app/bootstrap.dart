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

Future<void> _setupHive() async {
  await Hive.initFlutter();
  // Register adapters here when you create Hive models
  // Hive.registerAdapter(UserModelAdapter());
}

/*
Future<void> _setupFirebase(FlavorConfig config) async {
  await Firebase.initializeApp();

  // Flutter framework errors → Crashlytics
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (config.enableCrashlytics) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
  };

  // Disable Crashlytics in dev to avoid polluting reports
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    config.enableCrashlytics && !kDebugMode,
  );
}



Future<void> _setupRemoteConfig() async {
  try {
    final remoteConfig = getIt<RemoteConfigService>();
    await remoteConfig.initialize();
  } catch (e, s) {
    // Remote config failure must never crash the app
    AppLogger.warning('RemoteConfig init failed', error: e, stackTrace: s);
  }
}

Future<void> _setupNotifications() async {
  try {
    final notifications = getIt<PushNotificationService>();
    await notifications.initialize();
  } catch (e, s) {
    AppLogger.warning('Notifications init failed', error: e, stackTrace: s);
  }
}
*/
