import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class OrderDetailEntity extends Equatable {
  final int id;
  final String order;
  final String invoice;
  final String description;
  final double total;
  final double totalPago;
  final StatusEntity status;
  final List<ItemEntity> items;
  final List<PaymentEntity> payments;
  final List<ShippingEntity> shippings;
  final TranslationEntity translatons;

  const OrderDetailEntity({
    required this.id,
    required this.order,
    required this.invoice,
    required this.description,
    required this.total,
    required this.totalPago,
    required this.status,
    required this.items,
    required this.payments,
    required this.shippings,
    required this.translatons,
  });

  @override
  List<Object?> get props => [
    id,
    order,
    invoice,
    description,
    total,
    totalPago,
    status,
    items,
    payments,
    shippings,
    translatons
  ];
}
