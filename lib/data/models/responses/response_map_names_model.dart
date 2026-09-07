import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseMapNamesModel extends ResponseMapNamesEntity {
  const ResponseMapNamesModel({
    required super.countryId,
    required super.stateId,
    required super.cityId,
    required super.address1,
    required super.address2,
    required super.codeZip,
    required super.errors,
  });

  factory ResponseMapNamesModel.fromEntity(ResponseMapNamesEntity e) {
    return ResponseMapNamesModel(
      countryId: e.countryId,
      stateId: e.stateId,
      cityId: e.cityId,
      address1: e.address1,
      address2: e.address2,
      codeZip: e.codeZip,
      errors: e.errors,
    );
  }

  factory ResponseMapNamesModel.fromJson(Map<String, dynamic> json) {
    return ResponseMapNamesModel(
      countryId: safeInt(json['country_id']),
      stateId: safeInt(json['state_id']),
      cityId: safeInt(json['city_id']),
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      codeZip: safeString(json['code_zip']),
      errors: (json['errors'] is List) ? {} : json['errors'],
    );
  }
}
