import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CartEntity extends Equatable {
  final List<CartItemEntity> items;

  const CartEntity({required this.items});
  
  @override
  List<Object?> get props => [items];
}
