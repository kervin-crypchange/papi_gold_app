import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseOrdersModel extends ResponseOrdersEntity {
  const ResponseOrdersModel({required super.data});

  factory ResponseOrdersModel.fromJson(Map<String, dynamic> json) {
    return ResponseOrdersModel(
      data: safeList(json['data'], (x) => OrderDetailModel.fromJson(x)),
    );
  }
}
