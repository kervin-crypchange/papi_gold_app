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
      carats: json['carats'],
      categories: json['categories'],
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
