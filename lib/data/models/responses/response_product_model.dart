import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseProductModel extends ApiResponseEntity<ProductInfoModel> {
  final MetaModel meta;
  const ResponseProductModel({required super.data, required this.meta});
}

class ProductInfoModel {
  final int id;
  final String name;
  final List<ProductModel> products;

  const ProductInfoModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) {
    return ProductInfoModel(
      id: safeInt(['id']),
      name: safeString(['name']),
      products: safeList<ProductModel>([
        'producs',
      ], (x) => ProductModel.fromJson(x as Map<String, dynamic>)),
    );
  }
}
