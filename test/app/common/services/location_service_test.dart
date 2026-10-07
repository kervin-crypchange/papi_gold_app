import 'dart:io';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/common/services/location_service.dart';

void main() {
  late Directory hiveDirectory;
  late Box config;
  final locationService = LocationService();

  setUpAll(() async {
    hiveDirectory = await Directory.systemTemp.createTemp(
      'papi_gold_location_test_',
    );
    Hive.init(hiveDirectory.path);
    config = await Hive.openBox(BoxEnum.config.name);
  });

  setUp(() async {
    await config.clear();
  });

  tearDownAll(() async {
    await config.close();
    await Hive.close();
    await hiveDirectory.delete(recursive: true);
  });

  test('uses neutral coordinates when no map point has been saved', () {
    expect(locationService.lastSelectedMapPosition, isNull);
    expect(
      locationService.initialMapPosition,
      LocationService.neutralMapPosition,
    );
  });

  test('persists the last manually selected map point', () async {
    final position = GeoPoint(latitude: 18.4861, longitude: -69.9312);

    await locationService.saveLastSelectedMapPosition(position);

    final savedPosition = locationService.initialMapPosition;
    expect(savedPosition.latitude, position.latitude);
    expect(savedPosition.longitude, position.longitude);
  });
}
