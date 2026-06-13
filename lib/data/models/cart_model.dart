import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items});

  /// Converts a JSON map to a [CartModel].
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: safeList<ItemModel>(json['items'], (x) => ItemModel.fromJson(x as Map<String, dynamic>)),
    );
  }

  /// Converts a [CartEntity] to a [CartModel].
  factory CartModel.fromEntity(CartEntity e) {
    return CartModel(items: e.items);
  }

  /// Converts a [CartModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      "items": List<ItemModel>.from(
        items.map((e) => ItemModel.fromEntity(e).toJson()).toList(),
      ),
      };
  }
}
