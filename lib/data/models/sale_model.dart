import 'package:papi_gold/domain/entities/sale_entity.dart';

class SaleModel extends SaleEntity {
  const SaleModel({
    required super.order,
    required super.invoice,
    required super.total,
  });

    /// Converts a JSON map to a [SaleModel].
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      order: json['order'] as String,
      invoice: json['invoice_number'] as String,
      total: json['total_v'] as double,
    );
  }

  /// Converts a [SaleModel] to a [SaleEntity].
  factory SaleModel.fromEntity( SaleEntity e) {
    return SaleModel(
      order: e.order,
      invoice: e.invoice,
      total: e.total,
    );
  }

  /// Converts a [SaleModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'order': order,
      'invoice_number': invoice,
      'total_v': total,
    };
  }
}
