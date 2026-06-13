import 'package:papi_gold/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.quantity,
    required super.price,
    required super.format,
  });

  /// Converts a JSON map to a [ItemModel].
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      format: (json['format'] as num).toInt(),
    );
  }

  /// Converts a [ItemEntity] to a [ItemModel].
  factory ItemModel.fromEntity(ItemEntity e) {
    return ItemModel(
      id: e.id,
      quantity: e.quantity,
      price:e.price,
      format: e.format
    );
  }

  /// Converts a [ItemModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'format': format,
    };
  }
}
