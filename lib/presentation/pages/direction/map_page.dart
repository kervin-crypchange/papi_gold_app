import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GeoPoint? location;
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
                  debugPrint('--- MapPage LocationUpdate: $value');
                  setState(() {
                    location = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirma tu dirección',
                      style: context.titleMedium,
                    ).medium.paddingOnly(top: 12.h),
                    Column(
                      children: [
                        Text('Latitud: ${location?.latitude}'),
                        Text('Longitud: ${location?.longitude}'),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButtonWidget(
                        title: 'Confirmar',
                        onPressed: () {},
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
