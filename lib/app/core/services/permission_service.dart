import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Singleton
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  Future<PermissionStatus> checkPermission(Permission permission) async {
    return permission.status;
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return permission.request();
  }

  Future<bool> openAppSettingsScreen() async {
    return openAppSettings();
  }
}
