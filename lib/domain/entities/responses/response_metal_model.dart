import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseMetalModel extends ApiResponseEntity<MetalEntity>{
  final bool success;
  const ResponseMetalModel({required super.data, required this.success});

  factory ResponseMetalModel.fromJson(Map<String, dynamic> json){
    return ResponseMetalModel(
      success: safeBool(json['success']),
      data: safeList<MetalModel>(json['data'], (x)=> MetalModel.fromJson(x)),

    );
  }
}