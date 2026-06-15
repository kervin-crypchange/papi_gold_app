import 'package:papi_gold/app/common/utils/utils.dart';
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
      id: safeInt(json['id']),
      name: safeString(json['name']),
      countryId: safeString(json['country_id']),
    );
  }

  /// Converts a [LocationEntity] to a [LocationModel].
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
