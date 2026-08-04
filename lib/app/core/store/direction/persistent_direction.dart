import 'dart:developer';
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
  }

  Future<void> addDirections(List<PersistenDirectionModel> directions) async {
    for (final direction in directions) {
      DirectionController().addDirection(direction);
      log('Direction added to Hive box: ${direction.toJson()}');
    }
  }

  Future<void> addDirection(PersistenDirectionModel direction) async {
    DirectionController().addDirection(direction);
    log('Direction added to Hive box: ${direction.toJson()}');
  }

  Future<bool> removeDirection(int id) async {
    bool removed = DirectionController().removeDirection(id);
    if (removed) {
      log('Direction removed from Hive box: $id');
    } else {
      log('Direction not found in the box: $id');
    }
    return removed;
  }

  void clear() {
   DirectionController().clear();
    log('All directions cleared from Hive box');
  }

  Widget showDirections({
    required  Widget Function(
      BuildContext context,
      List<PersistenDirectionModel> directions,
    ) directionBuilder,
  }){
    return ValueListenableBuilder<Box<PersistenDirectionModel>>(
      valueListenable: DirectionController().directionListenable,
      builder: (context, box, child) {
        final directions = DirectionController().getAllDirections();

        return directionBuilder(context, directions);
      },
    );
    
  }
}
