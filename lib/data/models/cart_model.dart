import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items});

  /// Converts a JSON map to a [CartModel].
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: List<ItemModel>.from(
        json['item'].map((x) => ItemModel.fromJson(x)),
      ),
    );
  }

  /// Converts a [CartModel] to a [CartEntity].
  factory CartModel.fromEntity(CartEntity e) {
    return CartModel(items: e.items);
  }

  /// Converts a [CartModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {"items": List<ItemModel>.from(items.map((x) => x)),};
  }
}
