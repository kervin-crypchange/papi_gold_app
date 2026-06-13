import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int id;
  final int quantity;
  final double price;
  final int format;

  const ItemEntity({
    required this.id,
    required this.quantity,
    required this.price,
    required this.format,
  });

  @override
  List<Object?> get props => [id, quantity, price, format];
}
