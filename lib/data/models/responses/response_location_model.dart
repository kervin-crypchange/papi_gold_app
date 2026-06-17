import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/country_model.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseLocationModel extends ApiResponseEntity<CountryEntity> {
  const ResponseLocationModel({required super.data});

  factory ResponseLocationModel.fromEntity(ApiResponseEntity<CountryEntity> e) {
    return ResponseLocationModel(data: e.data);
  }

  factory ResponseLocationModel.fromJson(Map<String, dynamic> json) {
    return ResponseLocationModel(
      data: safeList<CountryModel>([
        'data',
      ], (x) => CountryModel.fromJson(x as Map<String, dynamic>)),
    );
  }
}
