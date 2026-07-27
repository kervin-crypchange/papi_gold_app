import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/common/widgets/index.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: MapController(
        initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
        areaLimit: const BoundingBox(
          east: 10.4922941,
          north: 47.8084648,
          south: 45.817995,
          west: 5.9559113,
        ),
      ),
      osmOption: OSMOption(
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
        zoomOption: const ZoomOption(
          initZoom: 8,
          minZoomLevel: 3,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(Icons.double_arrow, size: 48),
          ),
        ),
        roadConfiguration: const RoadOption(roadColor: Colors.yellowAccent),
      ),
    );
  }
}
