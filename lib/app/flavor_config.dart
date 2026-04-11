enum AppFlavor {
  dev,
  staging,
  production;

  String get name => switch (this) {
    AppFlavor.dev => 'dev',
    AppFlavor.staging => 'staging',
    AppFlavor.production => 'production',
  };
}
class FlavorConfig {
  const FlavorConfig({
    required this.name,
    required this.baseUrl,
    required this.socketUrl,
    required this.apiTimeout,
    required this.enableLogging,
    required this.enableCrashlytics,
  });

  final String name;
  final String baseUrl;
  final String socketUrl;
  final int apiTimeout;
  final bool enableLogging;
  final bool enableCrashlytics;

  @override
  String toString() => 'FlavorConfig(name: $name, baseUrl: $baseUrl)';
}
