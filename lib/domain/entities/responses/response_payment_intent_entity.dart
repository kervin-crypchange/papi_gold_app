import 'package:equatable/equatable.dart';

class ResponsePaymentIntentEntity extends Equatable {
  final String clientSecret;
  final int paymentId;

  const ResponsePaymentIntentEntity({
    required this.clientSecret,
    required this.paymentId,
  });

  @override
  List<Object?> get props => [clientSecret, paymentId];
}
