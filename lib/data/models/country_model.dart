import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
    required super.iso2,
    required super.phoneCode,
    required super.emoji,
  });

    /// Converts a JSON map to a [Model].
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      iso2: safeString(json['iso2']),
      phoneCode: safeString(json['phone_code']),
      emoji: safeString(json['emoji']),
    );
  }

  /// Converts a [CountryEntity] to a [CountryModel].
  factory CountryModel.fromEntity( CountryEntity e) {
    return CountryModel(
      id: e.id,
      name: e.name,
      iso2: e.iso2,
      phoneCode: e.phoneCode,
      emoji: e.emoji,
    );
  }

  /// Converts a [Model] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'iso2': iso2,
      'phone_code': phoneCode,
      'emoji': emoji,
    };
  }
}
