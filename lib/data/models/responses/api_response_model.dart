import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ApiResponseModel<T> extends ApiResponseEntity<T> {
  const ApiResponseModel({required super.data, super.meta, super.stats});

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) buildT,
  ) {
    return ApiResponseModel<T>(
      data: safeList<T>([
        'data',
      ], (x) => buildT(json['data'] as Map<String, dynamic>)),
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      stats: json['meta'] != null
          ? StatsModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}
