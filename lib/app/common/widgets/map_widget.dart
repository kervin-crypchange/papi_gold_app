import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/common/widgets/index.dart';

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

    controller = MapController.customLayer(
      customTile: CustomTile.openFreeMap(minZoomLevel: 3, maxZoomLevel: 19),
      initMapWithUserPosition: const UserTrackingOption(),
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
    try {
      await controller.moveTo(
        GeoPoint(latitude: point.latitude, longitude: point.longitude),
        animate: true,
      );
      await controller.changeLocationMarker(
        oldLocation: lastGeoPoint.value!,
        newLocation: point,
      );
      lastGeoPoint.value = point;
    } catch (e) {
      debugPrint('--- changeLocation error $e');
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      osmOption: osmOptions,
      onLocationChanged: (point) async {
        lastGeoPoint.value = point;
        controller.addMarker(point);
      },
    );
  }
}
