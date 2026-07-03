import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponsePaymentIntentModel extends ResponsePaymentIntentEntity {
  const ResponsePaymentIntentModel({
    required super.clientSecret,
    required super.paymentId,
  });

  factory ResponsePaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return ResponsePaymentIntentModel(
      clientSecret: safeString(['clientSecret']),
      paymentId: safeInt(json['paymentId']),
    );
  }
}
