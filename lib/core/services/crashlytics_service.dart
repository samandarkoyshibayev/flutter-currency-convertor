import 'package:currency_converter/core/utils/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract class CrashlyticsService {
  static FirebaseCrashlytics get _instance => FirebaseCrashlytics.instance;

  static Future<void> initialize() async {
    await _instance.setCrashlyticsCollectionEnabled(!kDebugMode);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) {
        _instance.recordFlutterFatalError(details);
      }
    };

    AppLogger.info(
      'Crashlytics initialized — '
      'collection: ${!kDebugMode ? "enabled" : "disabled (debug)"}',
    );
  }

  static void recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      AppLogger.error(
        'Crashlytics.recordError (debug-only log)',
        error: error,
        stackTrace: stackTrace,
      );
      return;
    }

    _instance.recordError(error, stackTrace, reason: reason, fatal: fatal);
  }

  static Future<void> setUserId(String? userId) async {
    await _instance.setUserIdentifier(userId ?? '');
  }

  static Future<void> setContext(String key, Object value) async {
    if (kDebugMode) return;
    await switch (value) {
      String v => _instance.setCustomKey(key, v),
      int v => _instance.setCustomKey(key, v),
      double v => _instance.setCustomKey(key, v),
      bool v => _instance.setCustomKey(key, v),
      _ => _instance.setCustomKey(key, value.toString()),
    };
  }

  static void log(String message) {
    if (kDebugMode) return;
    _instance.log(message);
  }
}
