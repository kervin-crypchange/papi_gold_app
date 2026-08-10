import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:papi_gold/app/core/store/direction/controller/direction_controller.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

// Extension method for Iterable class
extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class PersistentDirection {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PersistenDirectionModelAdapter());
    await Hive.openBox<PersistenDirectionModel>('directionBox');
    await Hive.openBox<PersistenDirectionModel>('selectedDirectionBox');
  }

  Future<void> addSelected(PersistenDirectionModel direction) async {
    DirectionController().addSelectedDirection(direction);
  }

  Future<void> addDirections(List<PersistenDirectionModel> directions) async {
    for (final direction in directions) {
      DirectionController().addDirection(direction);
    }
  }

  Future<void> addDirection(PersistenDirectionModel direction) async {
    DirectionController().addDirection(direction);
  }

  Future<bool> removeDirection(int id) async {
    return DirectionController().removeDirection(id);
  }

  void clear() {
    DirectionController().clear();
  }

  PersistenDirectionModel selectedDirection(){
    return DirectionController().getSelectedDirection();
  }

  Widget showSelectedDirection({
    required Widget Function(
      BuildContext context,
      PersistenDirectionModel direction
    ) directionBuilder
  }){
    return ValueListenableBuilder<Box<PersistenDirectionModel>>(
      valueListenable: DirectionController().directionListeable,
      builder: (context, box, child) {
        final direction = DirectionController().getSelectedDirection();
        return directionBuilder(context, direction);
      },
    );
  }

  Widget showDirections({
    required Widget Function(
      BuildContext context,
      List<PersistenDirectionModel> directions,
    )
    directionBuilder,
  }) {
    return ValueListenableBuilder<Box<PersistenDirectionModel>>(
      valueListenable: DirectionController().directionsListenable,
      builder: (context, box, child) {
        final directions = DirectionController().getAllDirections();
        return directionBuilder(context, directions);
      },
    );
  }
}
