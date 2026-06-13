import 'package:papi_gold/domain/entities/item_entity.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

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
      id: safeInt(json['id']),
      quantity: safeInt(json['quantity']),
      price: safeDouble(json['price']),
      format: safeInt(json['format']),
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
