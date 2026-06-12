import 'package:papi_gold/domain/entities/index.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.name,
    required super.countryId,
  });

    /// Converts a JSON map to a [LocationModel].
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
    );
  }

  /// Converts a [LocationModel] to a [LocationEntity].
  factory LocationModel.fromEntity(LocationEntity e) {
    return LocationModel(
      id: e.id,
      name: e.name,
      countryId: e.countryId,
    );
  }

  /// Converts a [Model] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'country_id': countryId,
    };
  }
}
