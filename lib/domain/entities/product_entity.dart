import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int stock;
  final String imagen;
  final double price;
  final ProductCategoryEntity category;
  // final TranslationEntity translations;
  
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.imagen,
    required this.price,
    required this.category,
    // required this.translations,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    stock,
    imagen,
    price,
    category,
    // translations
  ];
}

class ProductCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String color;
  // final TranslationEntity translations;

  const ProductCategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    // required this.translations,
  });

  @override
  List<Object?> get props => [id, name, description, color];
}
