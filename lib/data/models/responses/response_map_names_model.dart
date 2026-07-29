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
  });

  factory ResponseMapNamesModel.fromEntity(ResponseMapNamesEntity e) {
    return ResponseMapNamesModel(
      countryId: e.countryId,
      stateId: e.stateId,
      cityId: e.cityId,
      address1: e.address1,
      address2: e.address2,
      codeZip: e.codeZip,
    );
  }

  factory ResponseMapNamesModel.fromJson(Map<String, dynamic> json) {
    return ResponseMapNamesModel(
      countryId: safeInt(json['countryId']),
      stateId: safeInt(json['stateId']),
      cityId: safeInt(json['cityId']),
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      codeZip: safeString(json['codeZip']),
    );
  }
}
