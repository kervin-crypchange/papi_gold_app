import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int stock;
  final String image;
  final double price;
  final ProductCategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.image,
    required this.price,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    stock,
    image,
    price,
    category,
  ];
}

class ProductCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String color;

  const ProductCategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, description, color];
}
