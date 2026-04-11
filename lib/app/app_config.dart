import 'package:currency_converter/app/flavor_config.dart';

class AppConfig {
  AppConfig._();

  static AppConfig? _instance;
  static AppConfig get instance {
    assert(
      _instance != null,
      'AppConfig not initialized. Call AppConfig.setup() in bootstrap.',
    );
    return _instance!;
  }

  late final AppFlavor flavor;
  late final String baseUrl;
  late final String socketUrl;
  late final int apiTimeout;
  late final bool enableLogging;
  late final bool enableCrashlytics;
  late final String flavorName;

  bool get isDev => flavor == AppFlavor.dev;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProduction => flavor == AppFlavor.production;

  static void setup({
    required AppFlavor flavor,
    required FlavorConfig flavorConfig,
  }) {
    assert(_instance == null, 'AppConfig.setup() must only be called once.');
    _instance = AppConfig._()
      ..flavor = flavor
      ..flavorName = flavorConfig.name
      ..baseUrl = flavorConfig.baseUrl
      ..socketUrl = flavorConfig.socketUrl
      ..apiTimeout = flavorConfig.apiTimeout
      ..enableLogging = flavorConfig.enableLogging
      ..enableCrashlytics = flavorConfig.enableCrashlytics;
  }

  static void reset() => _instance = null;

  @override
  String toString() =>
      'AppConfig('
      'flavor: $flavorName, '
      'baseUrl: $baseUrl, '
      'logging: $enableLogging, '
      'crashlytics: $enableCrashlytics'
      ')';
}
