import 'package:papi_gold/domain/entities/metal_entity.dart';

class MetalModel extends MetalEntity {
  const MetalModel({
    required super.symbol,
    required super.name,
    required super.price,
    required super.carats,
    required super.categories,
    required super.conversion,
    required super.priceHistory,
    required super.isStable,
    required super.lastUpdated,
  });

  /// Converts a JSON map to a [MetalModel].
  factory MetalModel.fromJson(Map<String, dynamic> json) {
    return MetalModel(
      symbol: json['symbol'],
      name: json['name'],
      price: json['price'],
      carats: List<CaratModel>.from(
        json['carats'].map((x) => CaratModel.fromJson(json['carats'])),
      ),
      categories: List<MetalCategoryModel>.from(
        json['categories'].map((x) => json['categories']),
      ),
      conversion: json['conversion'],
      priceHistory: json['priceHistory'],
      isStable: json['isStable'],
      lastUpdated: json['lastUpdated'],
    );
  }

  /// Converts a [MetalModel] to a [MetalEntity].
  factory MetalModel.fromEntity(MetalEntity e) {
    return MetalModel(
      symbol: e.symbol,
      name: e.name,
      price: e.price,
      carats: e.carats,
      categories: e.categories,
      conversion: e.conversion,
      priceHistory: e.priceHistory,
      isStable: e.isStable,
      lastUpdated: e.lastUpdated,
    );
  }

  /// Converts a [MetalModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
      'carats': carats,
      'categories': categories,
      'conversion': conversion,
      'priceHistory': priceHistory,
      'isStable': isStable,
      'lastUpdated': lastUpdated,
    };
  }
}

class CaratModel extends CaratEntity {
  const CaratModel({
    required super.id,
    required super.name,
    required super.purity,
    required super.law,
  });

  /// Converts a JSON map to a [CaratModel].
  factory CaratModel.fromJson(Map<String, dynamic> json) {
    return CaratModel(
      id: json['id'],
      name: json['name'],
      purity: json['purity'],
      law: json['law'],
    );
  }

  /// Converts a [CaratModel] to a [CaratEntity].
  factory CaratModel.fromEntity(CaratEntity e) {
    return CaratModel(id: e.id, name: e.name, purity: e.purity, law: e.law);
  }

  /// Converts a [CaratModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'purity': purity, 'law': law};
  }
}

class MetalCategoryModel extends MetalCategoryEntity {
  const MetalCategoryModel({
    required super.id,
    required super.name,
    required super.stock,
    required super.price,
  });

  /// Converts a JSON map to a [Model].
  factory MetalCategoryModel.fromJson(Map<String, dynamic> json) {
    return MetalCategoryModel(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      price: json['price'],
    );
  }

  /// Converts a [MetalCategoryModel] to a [MetalCategoryEntity].
  factory MetalCategoryModel.fromEntity(MetalCategoryEntity e) {
    return MetalCategoryModel(
      id: e.id,
      name: e.name,
      stock: e.stock,
      price: e.price,
    );
  }

  /// Converts a [MetalCategoryModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'stock': stock, 'price': price};
  }
}
