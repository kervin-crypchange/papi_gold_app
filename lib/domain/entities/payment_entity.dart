import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final int id;
  final double amount;
  final String reference;
  final String type;

  const PaymentEntity({
    required this.id,
    required this.amount,
    required this.reference,
    required this.type,
  });

  @override
  List<Object?> get props => [id, amount, reference, type];
}
