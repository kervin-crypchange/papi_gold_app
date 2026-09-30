import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:papi_gold/app/core/store/direction/controller/direction_controller.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';

void main() {
  setUp(() async {
    final directory = await getTemporaryDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PersistentDirectionModelAdapter());
    await Hive.deleteBoxFromDisk('directionBox');
    await Hive.deleteBoxFromDisk('selectedDirectionBox');
    await Hive.openBox<PersistentDirectionModel>('directionBox');
    await Hive.openBox<PersistentDirectionModel>('selectedDirectionBox');
  });

  tearDown(() async {
    await Hive.close();
  });

  test('returns null when no selected direction is stored', () {
    final controller = DirectionController();

    expect(controller.getSelectedDirectionOrNull(), isNull);
    expect(() => controller.getSelectedDirection(), throwsStateError);
    expect(PersistentDirection().selectedDirectionOrNull(), isNull);
  });
}
