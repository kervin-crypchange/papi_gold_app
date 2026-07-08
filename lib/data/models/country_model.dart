import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
    required super.phoneCode,
  });

    /// Converts a JSON map to a [Model].
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      phoneCode: safeString(json['phonecode']),
    );
  }

  /// Converts a [CountryEntity] to a [CountryModel].
  factory CountryModel.fromEntity( CountryEntity e) {
    return CountryModel(
      id: e.id,
      name: e.name,
      phoneCode: e.phoneCode,
    );
  }

  /// Converts a [Model] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'phonecode': phoneCode,
    };
  }
}
