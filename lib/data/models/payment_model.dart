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
      id: json['id'] as int,
      amount: json['amount'] as double,
      reference: json['reference'] as String,
      type: json['type'] as String,
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
