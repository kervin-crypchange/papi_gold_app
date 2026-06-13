import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseProductModel extends ProductResponseEntity {
  const ResponseProductModel({required super.data, required super.meta});
}

class DataModel extends DataEntity {
  const DataModel({
    required super.id,
    required super.name,
    required super.products,
  });

  /// Converts a JSON map to a [DataModel].
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      products: List<ProductModel>.from(
        json['products'].map((x) => ProductModel.fromJson(x as Map<String, dynamic>)),
      ),
    );
  }

  /// Converts a [DataEntity] to a [DataModel].
  factory DataModel.fromEntity(DataEntity e) {
    return DataModel(id: e.id, name: e.name, products: e.products);
  }

  /// Converts a [DataModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products': List<ProductModel>.from(
        products.map((x) => ProductModel.fromEntity(x).toJson()).toList(),
      ),
    };
  }
}
