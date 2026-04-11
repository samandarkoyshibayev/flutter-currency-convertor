abstract class StorageKeys {
  // Secure Storage
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userPin = 'user_pin';
  static const String biometricEnabled = 'biometric_enabled';

  // Local Storage (Hive / SharedPrefs)
  static const String currentUser = 'current_user';
  static const String isOnboarded = 'is_onboarded';
  static const String isLoggedIn = 'is_logged_in';
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String fcmToken = 'fcm_token';
  static const String lastSyncAt = 'last_sync_at';
  static const String appVersion = 'app_version';
}
