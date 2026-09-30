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
    Hive.registerAdapter(PersistentDirectionModelAdapter());
    await Hive.openBox<PersistentDirectionModel>('directionBox');
    await Hive.openBox<PersistentDirectionModel>('selectedDirectionBox');
  }

  Future<void> addSelected(PersistentDirectionModel direction) async {
    DirectionController().addSelectedDirection(direction);
  }

  Future<void> addDirections(List<PersistentDirectionModel> directions) async {
    for (final direction in directions) {
      DirectionController().addDirection(direction);
    }
  }

  Future<void> addDirection(PersistentDirectionModel direction) async {
    DirectionController().addDirection(direction);
  }

  Future<bool> removeDirection(int id) async {
    return DirectionController().removeDirection(id);
  }

  void clear() {
    DirectionController().clear();
  }

  PersistentDirectionModel? selectedDirectionOrNull() {
    return DirectionController().getSelectedDirectionOrNull();
  }

  PersistentDirectionModel selectedDirection() {
    final direction = selectedDirectionOrNull();
    if (direction == null) {
      throw StateError('No selected direction found in the local storage.');
    }
    return direction;
  }

  Widget showSelectedDirection({
    required Widget Function(
      BuildContext context,
      PersistentDirectionModel direction
    ) directionBuilder,
    Widget Function(BuildContext context)? emptyBuilder,
  }){
    return ValueListenableBuilder<Box<PersistentDirectionModel>>(
      valueListenable: DirectionController().selectedDirectionsListenable,
      builder: (context, box, child) {
        final direction = DirectionController().getSelectedDirectionOrNull();
        if (direction == null) {
          if (emptyBuilder != null) {
            return emptyBuilder(context);
          }
          return const SizedBox.shrink();
        }
        return directionBuilder(context, direction);
      },
    );
  }

  Widget showDirections({
    required Widget Function(
      BuildContext context,
      List<PersistentDirectionModel> directions,
    )
    directionBuilder,
  }) {
    return ValueListenableBuilder<Box<PersistentDirectionModel>>(
      valueListenable: DirectionController().directionsListenable,
      builder: (context, box, child) {
        final directions = DirectionController().getAllDirections();
        return directionBuilder(context, directions);
      },
    );
  }
}
