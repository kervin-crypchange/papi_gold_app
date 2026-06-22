import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int id;
  final int quantity;
  final double price;
  final int format;

  const CartItemEntity({
    required this.id,
    required this.quantity,
    required this.price,
    required this.format,
  });

  @override
  List<Object?> get props => [id, quantity, price, format];
}
