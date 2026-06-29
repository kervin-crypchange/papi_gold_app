import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/product_info_entity.dart';

class ProductInfoModel extends ProductInfoEntity {
  const ProductInfoModel({
    required super.id,
    required super.name,
    required super.products,
  });

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) {
    return ProductInfoModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      products: safeList<ProductModel>(
        json['products'],
        (x) => ProductModel.fromJson(x),
      ),
    );
  }
}
