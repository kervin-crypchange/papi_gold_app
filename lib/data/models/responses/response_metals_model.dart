import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseMetalsModel extends ResponseMetalsEntity {
  const ResponseMetalsModel({required super.data});

  factory ResponseMetalsModel.fromJson(Map<String, dynamic> json) {
    return ResponseMetalsModel(
      data: safeList(json['data'], (x) => MetalModel.fromJson(x)),
    );
  }
}
