import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

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
  });

  /// Converts a JSON map to a [OrderDetailModel].
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'] as int,
      order: json['order'] as String,
      invoice: json['invoice'] as String,
      description: json['description'] as String,
      total: json['total_v'] as double,
      totalPago: json['total_pago_v'] as double,
      status: json['status'],
      items: List<ItemModel>.from(
        json['items'].map((x) => ItemModel.fromJson(x)),
      ),
      payments: List<PaymentModel>.from(
        json['payments'].map((x) => PaymentModel.fromJson(x)),
      ),
      shippings: List<ShippingModel>.from(
        json['shippings'].map((x) => ShippingModel.fromJson(x)),
      ),
    );
  }

  /// Converts a [OrderDetailModel] to a [OrderDetailEntity].
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
    );
  }

  /// Converts a [OrderDetailModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'invoice': invoice,
      'description': description,
      'total_v': total,
      'total_pago_v': totalPago,
      'status': status,
      'items': items,
      'payments': payments,
      'shippings': shippings,
    };
  }
}
