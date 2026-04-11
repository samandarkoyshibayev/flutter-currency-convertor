abstract class ApiConstants {
  // Timeouts (ms)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAccept = 'Accept';
  static const String headerAuthorization = 'Authorization';
  static const String headerLang = 'Accept-Language';
  static const String headerAppVersion = 'X-App-Version';
  static const String headerPlatform = 'X-Platform';
  static const String contentTypeJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';

  // Endpoints
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/me';

  // User
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // Pagination defaults
  static const int defaultPage = 1;
  static const int defaultLimit = 20;
}
