import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/services/location_service.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  late GeoPoint currentPosition;
  late MapController controller;
  late OSMOption osmOptions = OSMOption(
    showZoomController: true,
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
    final double latitude = LocationService().locationData.latitude;
    final double longitude = LocationService().locationData.longitude;
    currentPosition = GeoPoint(latitude: latitude, longitude: longitude);
  }

  Future<void> initMap() async {
    final double latitude = LocationService().locationData.latitude;
    final double longitude = LocationService().locationData.longitude;

    currentPosition = GeoPoint(latitude: latitude, longitude: longitude);

    controller = MapController.customLayer(
      initPosition: currentPosition,
      customTile: CustomTile.openFreeMap(minZoomLevel: 3, maxZoomLevel: 19),
    );

    // controller.listenerMapSingleTapping.addListener(() async {
    //   final GeoPoint? mapSingleTapping =
    //       controller.listenerMapSingleTapping.value;
    //   if (mapSingleTapping != null) {
    //     await _changeLocation(mapSingleTapping);
    //   }
    // });
  }

  Future<void> _changeLocation(GeoPoint point) async {
    try {
      if (lastGeoPoint.value != null) {
        await controller.removeMarker(lastGeoPoint.value!);
      }

      Future.delayed(Duration(milliseconds: 200), () async {
        await controller.addMarker(point);
      });

      await controller.moveTo(point, animate: true);

      lastGeoPoint.value = point;
    } catch (e) {
      debugPrint('--- changeLocation error $e');
    }
  }

  Future<void> onMapIsReady(bool isReady) async {
    debugPrint('--- onMapIsReady $isReady');
    if (isReady) {}
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          OSMFlutter(
            controller: controller,
            osmOption: osmOptions,
            onMapMoved: (p0) => debugPrint('--- onMapMoved $p0'),
            onMapIsReady: onMapIsReady,
          ),
          Icon(Icons.location_on, color: AppColors.error, size: 48),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.white,
                side: BorderSide(color: AppColors.bg),
              ),
              onPressed: () async =>
                  await controller.moveTo(currentPosition, animate: true),
              icon: Icon(Icons.my_location),
            ),
          ).paddingOnly(right: 10.w, bottom: 10.h),
        ],
      ),
    );
  }
}
