import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

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
  final TranslationEntity translations;

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
    required this.translations,
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
    translations,
  ];
}

class CaratEntity extends Equatable {
  final int id;
  final String name;
  final double purity;
  final String law;
  final TranslationEntity translations;

  const CaratEntity({
    required this.id,
    required this.name,
    required this.purity,
    required this.law,
    required this.translations,
  });

  @override
  List<Object?> get props => [id, name, purity, law, translations];
}

class MetalCategoryEntity extends Equatable {
  final int id;
  final String name;
  final int stock;
  final double price;
  final TranslationEntity translations;

  const MetalCategoryEntity({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.translations,
  });

  @override
  List<Object?> get props => [id, name, stock, price, translations];
}
