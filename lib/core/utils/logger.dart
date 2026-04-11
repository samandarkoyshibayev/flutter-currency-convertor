import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


/// Centralized logger for the entire app.
/// Wraps the [logger] package with level filtering based on [AppConfig].
///
/// Usage:
/// ```dart
/// AppLogger.debug('User loaded');
/// AppLogger.info('Token refreshed');
/// AppLogger.warning('Cache miss', error: e);
/// AppLogger.error('Login failed', error: e, stackTrace: s);
/// ```
abstract class AppLogger {
  static Logger? _logger;

  static Logger get _instance {
    _logger ??= Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: kDebugMode ? Level.debug : Level.warning,
      output: _AppLogOutput(),
    );
    return _logger!;
  }

  static bool get _isEnabled {
    try {
      return true;// AppConfig.instance.enableLogging;
    } catch (_) {
      return kDebugMode;
    }
  }

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isEnabled) return;
    _instance.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isEnabled) return;
    _instance.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isEnabled) return;
    _instance.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    // Errors always log regardless of flavor
    _instance.e(message, error: error, stackTrace: stackTrace);
  }

  static void wtf(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.f(message, error: error, stackTrace: stackTrace);
  }

  static void network({
    required String method,
    required String url,
    int? statusCode,
    dynamic data,
  }) {
    if (!_isEnabled) return;
    _instance.i(
      '[$method] $url ${statusCode != null ? '→ $statusCode' : ''}',
      error: data,
    );
  }
}

class _AppLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      debugPrint(line);
    }
  }
}