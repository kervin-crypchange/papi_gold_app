import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CartEntity extends Equatable {
  final List<ItemEntity> items;

  const CartEntity({required this.items});
  
  @override
  List<Object?> get props => [items];
}
