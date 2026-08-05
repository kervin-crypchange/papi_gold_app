import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

class DirectionController {
  final Box<PersistenDirectionModel> _directionBox =
      Hive.box<PersistenDirectionModel>('directionBox');

  final Box<PersistenDirectionModel> _selectedDirectionBox =
      Hive.box<PersistenDirectionModel>('selectedDirectionBox');

  ValueListenable<Box<PersistenDirectionModel>> get directionsListenable =>
      _directionBox.listenable();

  ValueListenable<Box<PersistenDirectionModel>> get directionListeable =>
      _selectedDirectionBox.listenable();

  void addSelectedDirection(PersistenDirectionModel direction) async {
    await _selectedDirectionBox.clear();
    _selectedDirectionBox.put(1, direction);
    log('--- AddSelectedDirection');
    
  }

  void addDirection(PersistenDirectionModel direction) {
    PersistenDirectionModel? existingDirection = _directionBox.get(
      direction.id,
    );
    if (existingDirection != null) {
      _directionBox.put(
        existingDirection.key,
        PersistenDirectionModel(
          id: existingDirection.id,
          name: existingDirection.name,
          lastName: existingDirection.lastName,
          email: existingDirection.email,
          phone: existingDirection.phone,
          country: existingDirection.country,
          state: existingDirection.state,
          city: existingDirection.city,
          address1: existingDirection.address1,
          address2: existingDirection.address2,
          codeZip: existingDirection.codeZip,
          type: existingDirection.type,
          isMain: existingDirection.isMain,
        ),
      );
    } else {
      _directionBox.put(
        direction.id,
        PersistenDirectionModel(
          id: direction.id,
          name: direction.name,
          lastName: direction.lastName,
          email: direction.email,
          phone: direction.phone,
          country: direction.country,
          state: direction.state,
          city: direction.city,
          address1: direction.address1,
          address2: direction.address2,
          codeZip: direction.codeZip,
          type: direction.type,
          isMain: direction.isMain,
        ),
      );
    }
  }

  bool removeDirection(int id) {
    if (_directionBox.containsKey(id)) {
      _directionBox.delete(id);
      return true;
    }
    return false;
  }

  List<PersistenDirectionModel> getAllDirections() {
    List<PersistenDirectionModel> directions = [];
    for (var direction in _directionBox.values) {
      directions.add(direction);
    }
    return directions;
  }

  PersistenDirectionModel getSelectedDirection() {
    return _selectedDirectionBox.values.first;
  }

  void clear() {
    _directionBox.clear();
    _selectedDirectionBox.clear();
  }
}
