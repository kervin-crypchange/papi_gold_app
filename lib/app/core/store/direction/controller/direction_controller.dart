import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

class DirectionController {
  final Box<PersistentDirectionModel> _directionBox =
      Hive.box<PersistentDirectionModel>('directionBox');

  final Box<PersistentDirectionModel> _selectedDirectionBox =
      Hive.box<PersistentDirectionModel>('selectedDirectionBox');

  ValueListenable<Box<PersistentDirectionModel>> get directionsListenable =>
      _directionBox.listenable();

  ValueListenable<Box<PersistentDirectionModel>> get selectedDirectionsListenable =>
      _selectedDirectionBox.listenable();

  @Deprecated('Use selectedDirectionsListenable')
  ValueListenable<Box<PersistentDirectionModel>> get directionListeable =>
      selectedDirectionsListenable;

  Future<void> addSelectedDirection(PersistentDirectionModel direction) async {
    await _selectedDirectionBox.clear();
    await _selectedDirectionBox.put(1, direction);
  }

  void addDirection(PersistentDirectionModel direction) {
    final nextDirection = PersistentDirectionModel(
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
    );

    _directionBox.put(direction.id, nextDirection);
  }

  bool removeDirection(int id) {
    if (_directionBox.containsKey(id)) {
      _directionBox.delete(id);
      return true;
    }
    return false;
  }

  List<PersistentDirectionModel> getAllDirections() {
    return _directionBox.values.toList(growable: false);
  }

  PersistentDirectionModel? getSelectedDirectionOrNull() {
    return _selectedDirectionBox.values.isEmpty
        ? null
        : _selectedDirectionBox.values.first;
  }

  PersistentDirectionModel getSelectedDirection() {
    final selectedDirection = getSelectedDirectionOrNull();
    if (selectedDirection == null) {
      throw StateError('No selected direction found in the local storage.');
    }
    return selectedDirection;
  }

  void clear() {
    _directionBox.clear();
    _selectedDirectionBox.clear();
  }
}
