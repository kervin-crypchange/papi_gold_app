import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Singleton
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  // Verificar estado de un permiso
  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // Solicitar permiso
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  // Verificar permisos múltiples a la vez
  Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  // Abrir la configuración del dispositivo si el permiso está denegado permanentemente
  Future<bool> openAppSettingsScreen() async {
    return await openAppSettings();
  }
}
