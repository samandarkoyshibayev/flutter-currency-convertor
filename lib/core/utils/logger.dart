import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

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

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kReleaseMode) return;
    _instance.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (kReleaseMode) return;
    _instance.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.e(message, error: error, stackTrace: stackTrace);
  }

  static void network({
    required String method,
    required String url,
    int? statusCode,
    dynamic data,
  }) {
    if (kReleaseMode) return;
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
