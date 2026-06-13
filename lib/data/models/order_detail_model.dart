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
  });

  /// Converts a JSON map to a [OrderDetailModel].
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: (json['id'] as num).toInt(),
      order: json['order'] as String,
      invoice: json['invoice'] as String,
      description: json['description'] as String,
        total: safeDouble(json['total_v']),
        totalPago: safeDouble(json['total_pago_v']),
        status: StatusModel.fromJson(json['status'] as Map<String, dynamic>),
        items: safeList<ItemModel>(json['items'], (x) => ItemModel.fromJson(x as Map<String, dynamic>)),
        payments: safeList<PaymentModel>(json['payments'], (x) => PaymentModel.fromJson(x as Map<String, dynamic>)),
        shippings: safeList<ShippingModel>(json['shippings'], (x) => ShippingModel.fromJson(x as Map<String, dynamic>)),
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
      'items': List<ItemModel>.from(
        items.map((e) => ItemModel.fromEntity(e).toJson()).toList(),
      ),
      'payments': List<PaymentModel>.from(
        payments.map((e) => PaymentModel.fromEntity(e).toJson()).toList(),
      ),
      'shippings': List<ShippingModel>.from(
        shippings.map((e) => ShippingModel.fromEntity(e).toJson()).toList(),
      ),
    };
  }
}
