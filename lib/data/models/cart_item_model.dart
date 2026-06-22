import 'package:papi_gold/domain/entities/cart_item_entity.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.quantity,
    required super.price,
    required super.format,
  });

  /// Converts a JSON map to a [CartItemModel].
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: safeInt(json['id']),
      quantity: safeInt(json['quantity']),
      price: safeDouble(json['price']),
      format: safeInt(json['format']),
    );
  }

  /// Converts a [CartItemEntity] to a [CartItemModel].
  factory CartItemModel.fromEntity(CartItemEntity e) {
    return CartItemModel(
      id: e.id,
      quantity: e.quantity,
      price:e.price,
      format: e.format
    );
  }

  /// Converts a [CartItemModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'format': format,
    };
  }
}
