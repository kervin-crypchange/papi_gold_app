import 'package:papi_gold/app/common/utils/utils.dart';
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
      order: safeString(json['order']),
      invoice: safeString(json['invoice_number']),
      total: safeDouble(json['total_v']),
    );
  }

  /// Converts a [SaleEntity] to a [SaleModel].
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
