import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.stock,
    required super.image,
    required super.price,
    required super.category,
  });

  /// Converts a JSON map to a [ProductModel].
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: safeInt(json['id']),
      name: safeString(json['name']) ,
      description: safeString(json['description']),
      stock: safeInt(json['stock'] ),
      image: safeString(json['image']),
      price: safeDouble(json['price']),
      category: ProducCategoryModel.fromJson(json['category']),
    );
  }

  /// Converts a [ProductEntity] to a [ProductModel].
  factory ProductModel.fromEntity(ProductEntity e) {
    return ProductModel(
      id: e.id,
      name: e.name,
      description: e.description,
      stock: e.stock,
      image: e.image,
      price: e.price,
      category: e.category,
    );
  }

  /// Converts a [ProductModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock': stock,
      'image': image,
      'price': price,
      'category': ProducCategoryModel.fromEntity(category).toJson(),
    };
  }
}

class ProducCategoryModel extends ProductCategoryEntity {
  const ProducCategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.color,
  });

  /// Converts a JSON map to a [ProducCategoryModel].
  factory ProducCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProducCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
    );
  }

  /// Converts a [ProducCategoryEntity] to a [ProducCategoryModel].
  factory ProducCategoryModel.fromEntity(ProductCategoryEntity e) {
    return ProducCategoryModel(
      id: e.id,
      name: e.name,
      description: e.description,
      color: e.color,
    );
  }

  /// Converts a [ProducCategoryModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'color': color};
  }
}
