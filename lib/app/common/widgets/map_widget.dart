import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/services/location_service.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:permission_handler/permission_handler.dart';

class MapWidget extends StatefulWidget {
  final ValueChanged<GeoPoint> onLocationUpdate;

  const MapWidget({super.key, required this.onLocationUpdate});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool isMapReady = false;
  final Debouncer _debouncer = Debouncer();
  late GeoPoint currentPosition = LocationService().initialMapPosition;
  late final bool _hasSavedPosition =
      LocationService().lastSelectedMapPosition != null;
  late MapController controller;
  late OSMOption osmOptions = OSMOption(
    showZoomController: true,
    isPicker: true,
    zoomOption: ZoomOption(initZoom: _hasSavedPosition ? 16 : 3),
  );

  @override
  void initState() {
    super.initState();
    initMap();
  }

  void initMap() {
    controller = MapController.customLayer(
      initPosition: currentPosition,
      customTile: CustomTile(
        urlsServers: [
          TileURLs(url: "https://api.maptiler.com/maps/openstreetmap"),
        ],
        tileExtension: 'png',
        sourceName: 'osm',
        styleURL:
            "https://api.maptiler.com/maps/openstreetmap/style.json?key=kctGi403t1Oerd90Atq6",
      ),
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
      onDebounce: () async {
        currentPosition = region.center;
        await LocationService().saveLastSelectedMapPosition(currentPosition);
        widget.onLocationUpdate(currentPosition);
      },
    );
  }

  Future<void> _moveToCurrentLocation() async {
    final result = await LocationService().requestCurrentPosition();
    if (!mounted) return;

    final position = result.position;
    if (position == null) {
      if (result.permissionStatus.isPermanentlyDenied ||
          result.permissionStatus.isRestricted) {
        final openSettings = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permiso de ubicación'),
            content: const Text(
              'El permiso está bloqueado. Puedes habilitarlo desde los ajustes '
              'de la aplicación o continuar seleccionando el punto en el mapa.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Ahora no'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Abrir ajustes'),
              ),
            ],
          ),
        );
        if (openSettings == true) {
          final opened = await LocationService().openSettings();
          if (!opened && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No se pudieron abrir los ajustes de la aplicación.'),
              ),
            );
          }
        }
      } else {
        final message = !result.permissionStatus.isGranted
            ? 'No se concedió el permiso. Puedes elegir una ubicación en el mapa.'
            : !result.serviceEnabled
            ? 'Activa el servicio de ubicación o elige un punto en el mapa.'
            : 'No se pudo obtener tu ubicación. Puedes elegir un punto en el mapa.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
      return;
    }

    currentPosition = position;
    await LocationService().saveLastSelectedMapPosition(position);
    await controller.moveTo(position, animate: true);
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
            mapIsLoading: LoadingAnimatedWidget(),
            controller: controller,
            osmOption: osmOptions,
            onMapIsReady: (p0) => setState(() => isMapReady = p0),
            onMapMoved: _onMapMoved,
          ),
          if (isMapReady)
            Icon(Icons.location_on, color: AppColors.error, size: 48),
          if (isMapReady)
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                onPressed: _moveToCurrentLocation,
                icon: Icon(Icons.my_location),
              ),
            ).paddingOnly(right: 10.w, bottom: 10.h),
        ],
      ),
    );
  }
}
