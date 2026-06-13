import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items});

  /// Converts a JSON map to a [CartModel].
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: List<ItemModel>.from(
        json['items'].map((x) => ItemModel.fromJson(x as Map<String, dynamic>)),
      ),
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
