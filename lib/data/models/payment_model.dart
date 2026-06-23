import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.amount,
    required super.reference,
    required super.type,
    required super.status,
    required super.createdAt,
  });

    /// Converts a JSON map to a [PaymentModel].
  factory PaymentModel.fromJson(Map<String, dynamic> json) {

    return PaymentModel(
      id: safeInt(json['id']),
      amount: safeDouble(json['amount']),
      reference: safeString(json['reference']),
      type: safeString(json['type']),
      createdAt: safeDateTime(json['created_at']),
      status: StatusModel.fromJson(json['status'])
    );
  }

  /// Converts a [PaymentEntity] to a [PaymentModel].
  factory PaymentModel.fromEntity( PaymentEntity e) {
    return PaymentModel(
      id: e.id,
      amount: e.amount,
      reference: e.reference,
      type: e.type,
      status: e.status,
      createdAt: e.createdAt,
    );
  }
}
