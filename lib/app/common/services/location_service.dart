import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location/location.dart';

class LocationService {
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  GeoPoint? _geoPoint;
  final Location _location = Location();

  LocationData get locationData => _locationData!;
  GeoPoint get geoPoint => _geoPoint!;

  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;
  LocationService._internal();

  Future<void> init() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    _geoPoint = GeoPoint(
      latitude: _locationData!.latitude,
      longitude: _locationData!.longitude,
    );
  }
}
