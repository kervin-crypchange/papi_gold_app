import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

class OrderDetailModel extends OrderDetailEntity {
  const OrderDetailModel({
    required super.id,
    required super.order,
    required super.invoice,
    required super.description,
    required super.total,
    required super.totalPago,
    required super.status,
    required super.items,
    required super.payments,
    required super.shippings,
    // required super.translatons,
  });

  /// Converts a JSON map to a [OrderDetailModel].
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: safeInt(json['id']),
      order: safeString(json['order']),
      invoice: safeString(json['invoice_number']),
      description: safeString(json['description']),
      total: safeDouble(json['total_v']),
      totalPago: safeDouble(json['total_pago_v']),
      status: StatusModel.fromJson(json['status'] as Map<String, dynamic>),
      items: safeList<ItemModel>(
        json['items'],
        (x) => ItemModel.fromJson(x as Map<String, dynamic>),
      ),
      payments: safeList<PaymentModel>(
        json['payments'],
        (x) => PaymentModel.fromJson(x as Map<String, dynamic>),
      ),
      shippings: safeList<ShippingModel>(
        json['shippings'],
        (x) => ShippingModel.fromJson(x as Map<String, dynamic>),
      ),
      // translatons: json['translations']
    );
  }

  /// Converts a [OrderDetailEntity] to a [OrderDetailModel].
  factory OrderDetailModel.fromEntity(OrderDetailEntity e) {
    return OrderDetailModel(
      id: e.id,
      order: e.order,
      invoice: e.invoice,
      description: e.description,
      total: e.total,
      totalPago: e.totalPago,
      status: e.status,
      items: e.items,
      payments: e.payments,
      shippings: e.shippings,
      // translatons: e.translatons,
    );
  }
}
