import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/status_entity.dart';

class PaymentEntity extends Equatable {
  final int id;
  final double amount;
  final String reference;
  final String type;
  final StatusEntity status;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.amount,
    required this.reference,
    required this.type,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, amount, reference, type, status, createdAt];
}
