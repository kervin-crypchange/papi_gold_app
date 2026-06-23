import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseProductsModel extends ResponseProductsEntity{
  const ResponseProductsModel({required super.data, required super.meta});

  factory ResponseProductsModel.fromJson(Map<String, dynamic> json){
    return ResponseProductsModel(
      data: safeList(json['data'], (x)=> ProductInfoModel.fromJson(x)),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}