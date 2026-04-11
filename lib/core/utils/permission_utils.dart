import 'package:permission_handler/permission_handler.dart';

import 'logger.dart';

abstract class PermissionUtils {
  static Future<bool> request(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      AppLogger.warning('[Permission] Permanently denied: $permission');
      return false;
    }

    final result = await permission.request();
    AppLogger.debug('[Permission] $permission → $result');
    return result.isGranted;
  }

  static Future<bool> requestCamera() => request(Permission.camera);

  static Future<bool> requestGallery() => request(Permission.photos);

  static Future<bool> requestLocation() => request(Permission.location);

  static Future<bool> requestNotification() => request(Permission.notification);

  static Future<bool> requestMicrophone() => request(Permission.microphone);

  static Future<bool> isPermanentlyDenied(Permission permission) async =>
      (await permission.status).isPermanentlyDenied;

  static Future<void> openSettings() => openAppSettings();
}
