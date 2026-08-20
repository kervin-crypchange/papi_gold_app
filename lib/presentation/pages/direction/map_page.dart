import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/services/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/directions/directions_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GeoPoint? location;
  NominatimResult? _result;

  Future<void> _fetchLocation() async {
    final r = await ReverseMapService.getReverseGeocoding(
      lat: location!.latitude,
      lon: location!.longitude,
    );

    setState(() {
      _result = r;
    });
  }

  void _displayError(Map<String, dynamic> errors){
    List<String> keys = errors.keys.toList();
    showOkAlertDialog(
      style: AdaptiveStyle.adaptive,
      context: context,
      title: 'Ha ocurrido un error',
      message: errors[keys[0]]
    );
  }

  @override
  Widget build(BuildContext context) {
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar dirección'),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.newAddress),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Scaffold(
        body: Column(
          children: [
            Container(
              height: 0.6.sh,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.blackLigth),
              child: MapWidget(
                onLocationUpdate: (value) {
                  setState(() {
                    location = value;
                    _fetchLocation();
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:
                              Text(
                                    _result?.name ?? '',
                                    style: context.labelLarge,
                                    textAlign: TextAlign.center,
                                  )
                                  .overflowText(TextOverflow.ellipsis)
                                  .medium
                                  .paddingOnly(top: 12.h),
                        ),
                      ],
                    ),
                    (_result == null)
                        ? LoadingWidget()
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estado: ${_result?.state}',
                                  style: context.bodyMedium,
                                ),
                                Text(
                                  'Ciudad: ${_result?.city}',
                                  style: context.bodyMedium,
                                ),
                                Text(
                                  'Municipio: ${_result!.municipality}',
                                  style: context.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButtonWidget(
                        title: 'Confirmar',
                        onPressed: () {
                          showLoading(context);
                          context
                              .read<DirectionsCubit>()
                              .mapNames(location!)
                              .then((either) {
                                either.fold((failure) => null, (response) {
                                  showLoading(context, false);
                                  debugPrint('--- $response');
                                  if(response.errors.isNotEmpty){
                                    _displayError(response.errors);
                                  }
                                  // context.read<DirectionsCubit>().mapName =
                                  //     response;
                                  // context.goNamed(Routes.newAddress);
                                });
                              });
                        },
                      ),
                    ).paddingOnly(bottom: navigationBarHeight + 6),
                  ],
                ).paddingSymmetric(horizontal: 12.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
