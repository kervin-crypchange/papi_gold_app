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
      id: json['id'] as int,
      name: json['name'] as String,
      iso2: json['iso2'] as String,
      phoneCode: json['phone_code'] as String,
      emoji: json['emoji'] as String,
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
