abstract class AppConstants {
  // App info
  static const String appName = 'MyApp';
  static const String supportEmail = 'support@myapp.com';
  static const String privacyPolicyUrl = 'https://myapp.com/privacy';
  static const String termsUrl = 'https://myapp.com/terms';

  // Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration toastDuration = Duration(seconds: 2);
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 350);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration debounceDelay = Duration(milliseconds: 400);
  static const Duration connectivityCheckDelay = Duration(seconds: 3);

  // Limits
  static const int maxImageSizeMb = 10;
  static const int maxFileSizeMb = 50;
  static const int passwordMinLength = 8;
  static const int otpLength = 6;
  static const int maxRetryAttempts = 3;
  static const double maxCacheAgeDays = 7;

  // Cache
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';
}
