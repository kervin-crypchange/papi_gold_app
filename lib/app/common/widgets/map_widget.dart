import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/services/location_service.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class MapWidget extends StatefulWidget {
  final ValueChanged<GeoPoint> onLocationUpdate;

  const MapWidget({super.key, required this.onLocationUpdate});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool isMapReady = false;
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  final Debouncer _debouncer = Debouncer();
  late GeoPoint currentPosition = LocationService().geoPoint;
  late MapController controller;
  late OSMOption osmOptions = OSMOption(
    showZoomController: true,
    isPicker: true,
    zoomOption: const ZoomOption(
      initZoom: 17,
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
    controller = MapController.customLayer(
      initPosition: currentPosition,
      customTile: CustomTile.openFreeMap(minZoomLevel: 3, maxZoomLevel: 19),
    );

    controller.listenerMapSingleTapping.addListener(() async {
      final GeoPoint? mapSingleTapping =
          controller.listenerMapSingleTapping.value;
      if (mapSingleTapping != null) {
        await controller.moveTo(mapSingleTapping, animate: true);
      }
    });
  }

  void _onMapMoved(Region region) async {
    if (!isMapReady) return;
    _debouncer.debounce(
      duration: Duration(milliseconds: 300),
      onDebounce: () => widget.onLocationUpdate(region.center),
    );
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
            mapIsLoading: LoadingWidget(),
            controller: controller,
            osmOption: osmOptions,
            onMapIsReady: (p0) => setState(() => isMapReady = p0),
            onMapMoved: _onMapMoved,
          ),
          if (isMapReady)
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
