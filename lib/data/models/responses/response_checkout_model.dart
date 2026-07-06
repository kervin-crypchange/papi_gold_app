import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseCheckOutModel extends ResponseCheckOutEntity {
  const ResponseCheckOutModel({
    required super.message,
    required super.sale,
    required super.items,
    required super.clientSecret,
    required super.paymentId,
  });

  factory ResponseCheckOutModel.fromJson(Map<String, dynamic> json) {
    return ResponseCheckOutModel(
      message: safeString(json['message']),
      sale: SaleModel.fromJson(json['sale'] as Map<String, dynamic>),
      items: safeList<ItemModel>(
        json['items'],
        (x) => ItemModel.fromJson(x),
      ),
      clientSecret: safeString(json['clientSecret']),
      paymentId: safeString(json['paymentId']),
    );
  }
}

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    required super.price,
    required super.type,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: safeInt(json['id']),
      product: safeString(json['product']),
      quantity: safeInt(json['quantity']),
      price: safeDouble(json['price']),
      type: safeString(json['type'])
    );
  }
}
