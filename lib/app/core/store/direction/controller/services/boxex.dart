import 'package:hive/hive.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

/// A utility class providing access to the Hive box for storing cart data.
class Boxes {
  /// Gets the Hive box for storing [PersistentShoppingCartItem] data.
  ///
  /// Returns a [Box] instance for interacting with the cart data stored in Hive.
  static Box<PersistenDirectionModel> getData() =>
      Hive.box<PersistenDirectionModel>('directionBox');
}
