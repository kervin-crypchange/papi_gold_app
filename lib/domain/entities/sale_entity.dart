import 'package:equatable/equatable.dart';

class SaleEntity extends Equatable {
  final String order;
  final String invoice;
  final double total;

  const SaleEntity({
    required this.order,
    required this.invoice,
    required this.total,
  });

  @override
  List<Object?> get props => [order, invoice, total];
}
