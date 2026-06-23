import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.amount,
    required super.reference,
    required super.type,
  });

    /// Converts a JSON map to a [PaymentModel].
  factory PaymentModel.fromJson(Map<String, dynamic> json) {

    return PaymentModel(
      id: safeInt(json['id']),
      amount: safeDouble(json['amount']),
      reference: safeString(json['reference']),
      type: safeString(json['type']),
    );
  }

  /// Converts a [PaymentEntity] to a [PaymentModel].
  factory PaymentModel.fromEntity( PaymentEntity e) {
    return PaymentModel(
      id: e.id,
      amount: e.amount,
      reference: e.reference,
      type: e.type,
    );
  }

  /// Converts a [PaymentModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'amount': amount,
      'reference': reference,
      'type': type,
    };
  }
}
