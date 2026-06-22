import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.product,
    required super.productId,
    required super.image,
    required super.quantity,
    required super.price,
    required super.total,
    required super.order,
    required super.type,
    required super.metalDetail,
    // required super.translations,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: safeInt(json['id']),
      product: safeString(json['product']),
      productId: safeInt(json['productId']),
      image: safeString(json['image']),
      quantity: safeInt(json['quantity']),
      price: safeDouble(json['price']),
      total: safeDouble(json['total']),
      order: safeInt(json['order']),
      type: safeString(json['type']),
      metalDetail: OrderMetalDetailModel.fromJson(json['metalDetail']),
      // translations: TranslationModel.fromJson(json['translations']),
    );
  }
}

class OrderMetalDetailModel extends OrderMetalDetailEntity {
  const OrderMetalDetailModel({
    required super.type,
    required super.weight,
    required super.conversion,
    required super.purity,
  });

  factory OrderMetalDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderMetalDetailModel(
      type: safeString(json['type']),
      weight: safeDouble(json['weight']),
      conversion: safeDouble(json['conversion']),
      purity: safeDouble(json['purity']),
    );
  }
}
