import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

class DirectionController {
  final Box<PersistenDirectionModel> _directionBox =
      Hive.box<PersistenDirectionModel>('directionBox');

  ValueListenable<Box<PersistenDirectionModel>> get directionBoxListenable =>
      _directionBox.listenable();

  void addDirection(PersistenDirectionModel direction) {
   PersistenDirectionModel? existingDirection = _directionBox.get(direction.id);
    if (existingDirection != null) {
      _directionBox.put(
        direction.id,
        PersistenDirectionModel(
          id: existingDirection.id,
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
    if( _directionBox.containsKey(id)) {
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

  void clear() {
    _directionBox.clear();
  }

}
