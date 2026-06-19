import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ApiResponseModel<T> extends ApiResponseEntity<T> {
  const ApiResponseModel({required super.data, super.meta, super.stats});

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawData = json['data'] as List? ?? [];
    return ApiResponseModel<T>(
      data: rawData
          .map((item) => fromJsonT(item))
          .toList(),
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'])
          : null,
      stats: json['meta'] != null
          ? StatsModel.fromJson(json['meta'])
          : null,
    );
  }
}
