import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/order_item_model.dart';
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
    required super.createdAt,
  });

  /// Converts a JSON map to a [OrderDetailModel].
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: safeInt(json['id']),
      status: StatusModel.fromJson(json['status']),
      description: safeString(json['description']),
      order: safeString(json['order']),
      total: safeDouble(json['total_v']),
      totalPago: safeDouble(json['total_pago_v']),
      invoice: safeString(json['invoice_number']),
      createdAt: safeDateTime(json['created_at']),
      items: safeList<OrderItemModel>(
        json['items'],
        (x) => OrderItemModel.fromJson(x),
      ),
      payments: safeList<PaymentModel>(
        json['payments'],
        (x) => PaymentModel.fromJson(x),
      ),
      shippings: safeList<ShippingModel>(
        json['shipping'],
        (x) => ShippingModel.fromJson(x),
      ),
    );
  }
}
