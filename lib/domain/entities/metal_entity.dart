import 'package:equatable/equatable.dart';

class MetalEntity extends Equatable {
  final String symbol;
  final String name;
  final double price;
  final double conversion;
  final double priceHistory;
  final bool isStable;
  final DateTime lastUpdated;
  final List<CaratEntity> carats;
  final List<MetalCategoryEntity> categories;

  const MetalEntity({
    required this.symbol,
    required this.name,
    required this.price,
    required this.carats,
    required this.categories,
    required this.conversion,
    required this.priceHistory,
    required this.isStable,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
    symbol,
    name,
    price,
    carats,
    categories,
    conversion,
    priceHistory,
    isStable,
    lastUpdated,
  ];
}

class CaratEntity extends Equatable {
  final int id;
  final String name;
  final String purity;
  final String law;

  const CaratEntity({
    required this.id,
    required this.name,
    required this.purity,
    required this.law,
  });

  @override
  List<Object?> get props => [id, name, purity, law];
}

class MetalCategoryEntity extends Equatable {
  final int id;
  final String name;
  final int stock;
  final double price;

  const MetalCategoryEntity({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, stock, price];
}
