import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/common/services/location_service.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  late MapController controller;
  late OSMOption osmOptions = OSMOption(
    isPicker: true,
    zoomOption: const ZoomOption(
      initZoom: 16,
      minZoomLevel: 3,
      maxZoomLevel: 19,
      stepZoom: 1.0,
    ),
  );

  @override
  void initState() {
    super.initState();
    initMap();
  }

  Future<void> initMap() async {
    debugPrint('--- initMap');
    final double latitude = LocationService().locationData.latitude;
    final double longitude = LocationService().locationData.longitude;

    controller = MapController.customLayer(
      initPosition: GeoPoint(latitude: latitude, longitude: longitude),
      customTile: CustomTile.openFreeMap(minZoomLevel: 3, maxZoomLevel: 19),
    );

    controller.listenerMapSingleTapping.addListener(() async {
      final GeoPoint? mapSingleTapping =
          controller.listenerMapSingleTapping.value;
      if (mapSingleTapping != null) {
        await _changeLocation(mapSingleTapping);
      }
    });
  }

  Future<void> _changeLocation(GeoPoint point) async {
    debugPrint('--- changeLocation: $point');

    try {
      await controller.moveTo(
        GeoPoint(latitude: point.latitude, longitude: point.longitude),
        animate: true,
      );
      lastGeoPoint.value = point;
    } catch (e) {
      debugPrint('--- changeLocation error $e');
    }
  }

  Future<void> onMapIsReady(bool isReady) async {
    debugPrint('--- onMapIsReady $isReady');
    if (isReady) {}
  }

  Future<void> _setMyLocation() async {
    debugPrint('--- SetMylocation');
    await controller.currentLocation();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: controller,
        osmOption: osmOptions,
        // onMapMoved: (p0) => debugPrint('--- onMapMoved $p0'),
        onMapIsReady: onMapIsReady,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _setMyLocation,
        child: Icon(Icons.my_location, color: AppColors.white),
      ),
    );
  }
}
