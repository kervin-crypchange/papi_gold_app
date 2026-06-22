import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class OrderItemEntity extends Equatable {
  final int id;
  final String product;
  final int productId;
  final String image;
  final int quantity;
  final double price;
  final double total;
  final int order;
  final String type;
  final OrderMetalDetailEntity metalDetail;
  final TranslationEntity translations;

  const OrderItemEntity({
    required this.id,
    required this.product,
    required this.productId,
    required this.image,
    required this.quantity,
    required this.price,
    required this.total,
    required this.order,
    required this.type,
    required this.metalDetail,
    required this.translations,
  });

  @override
  List<Object?> get props => [
    id,
    product,
    productId,
    image,
    quantity,
    price,
    total,
    order,
    type,
    metalDetail,
    translations,
  ];
}

class OrderMetalDetailEntity extends Equatable {
  final String type;
  final double weight;
  final double conversion;
  final double purity;

  const OrderMetalDetailEntity({
    required this.type,
    required this.weight,
    required this.conversion,
    required this.purity,
  });

  @override
  List<Object?> get props => [type, weight, conversion, purity];
}
