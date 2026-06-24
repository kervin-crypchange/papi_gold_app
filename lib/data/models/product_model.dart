import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.stock,
    required super.imagen,
    required super.price,
    required super.category,
    // required super.translations,
  });

  /// Converts a JSON map to a [ProductModel].
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      description: safeString(json['description']),
      stock: safeInt(json['stock']),
      imagen: safeString(json['imagen']),
      price: safeDouble(json['price']),
      category: ProducCategoryModel.fromJson(json['category']),
      // translations: TranslationModel.fromJson(
      //   json['translations'] as Map<String, dynamic>,
      // ),
    );
  }
}

class ProducCategoryModel extends ProductCategoryEntity {
  const ProducCategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.color,
    // required super.translations,
  });

  /// Converts a JSON map to a [ProducCategoryModel].
  factory ProducCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProducCategoryModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      description: safeString(json['description']),
      color: safeString(json['color']),
      // translations: TranslationModel.fromJson(
      //   json['translations'] as Map<String, dynamic>,
      // ),
    );
  }
}
