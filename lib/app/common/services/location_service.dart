import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/core/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class LocationResult {
  final GeoPoint? position;
  final permission.PermissionStatus permissionStatus;
  final bool serviceEnabled;
  final bool acquisitionFailed;

  const LocationResult({
    required this.position,
    required this.permissionStatus,
    required this.serviceEnabled,
    this.acquisitionFailed = false,
  });
}

class LocationService {
  static final GeoPoint neutralMapPosition = GeoPoint(
    latitude: 0,
    longitude: 0,
  );

  final Location _location = Location();

  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;
  LocationService._internal();

  GeoPoint get initialMapPosition =>
      lastSelectedMapPosition ?? neutralMapPosition;

  GeoPoint? get lastSelectedMapPosition {
    final value = Hive.box(BoxEnum.config.name).get(
      BoxEnum.config.lastMapPosition,
    );
    if (value is! List || value.length != 2) return null;

    final latitude = value[0];
    final longitude = value[1];
    if (latitude is! num || longitude is! num) return null;

    return GeoPoint(
      latitude: latitude.toDouble(),
      longitude: longitude.toDouble(),
    );
  }

  Future<void> saveLastSelectedMapPosition(GeoPoint position) async {
    await Hive.box(BoxEnum.config.name).put(
      BoxEnum.config.lastMapPosition,
      [position.latitude, position.longitude],
    );
  }

  Future<bool> openSettings() {
    return PermissionService().openAppSettingsScreen();
  }

  Future<LocationResult> requestCurrentPosition() async {
    var status = await PermissionService().checkPermission(
      permission.Permission.locationWhenInUse,
    );
    if (status.isDenied) {
      status = await PermissionService().requestPermission(
        permission.Permission.locationWhenInUse,
      );
    }

    if (!status.isGranted) {
      return LocationResult(
        position: null,
        permissionStatus: status,
        serviceEnabled: false,
      );
    }

    try {
      var serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
      }
      if (!serviceEnabled) {
        return LocationResult(
          position: null,
          permissionStatus: status,
          serviceEnabled: false,
        );
      }

      final locationData = await _location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;
      final position = GeoPoint(latitude: latitude, longitude: longitude);
      return LocationResult(
        position: position,
        permissionStatus: status,
        serviceEnabled: true,
      );
    } on PlatformException catch (error, stackTrace) {
      debugPrint('Could not retrieve the current location: $error');
      debugPrintStack(stackTrace: stackTrace);
      return LocationResult(
        position: null,
        permissionStatus: status,
        serviceEnabled: true,
        acquisitionFailed: true,
      );
    }
  }
}
