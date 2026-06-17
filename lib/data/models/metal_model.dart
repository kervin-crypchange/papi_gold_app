import 'package:papi_gold/domain/entities/metal_entity.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

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
      symbol: safeString(json['symbol']),
      name: safeString(json['name']),
      price: safeDouble(json['price']),
      carats: safeList<CaratModel>(json['carats'], (x) => CaratModel.fromJson(x)),
      categories: safeList<MetalCategoryModel>(json['categories'], (x) => MetalCategoryModel.fromJson(x as Map<String, dynamic>)),
      conversion: safeDouble(json['conversion']),
      priceHistory: safeDouble(json['priceHistory']),
      isStable: safeBool(json['isStable']),
      lastUpdated: safeDateTime(json['lastUpdated']),
    );
  }

  /// Converts a [MetalEntity] to a [MetalModel].
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
      'carats': List<CaratModel>.from(
        carats.map((e) => CaratModel.fromEntity(e).toJson()).toList(),
      ),
      'categories': List<MetalCategoryModel>.from(
        categories
            .map((e) => MetalCategoryModel.fromEntity(e).toJson())
            .toList(),
      ),
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

  /// Converts a [CaratEntity] to a [CaratModel].
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

  /// Converts a [MetalCategoryEntity] to a [MetalCategoryModel].
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
