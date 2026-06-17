import 'package:papi_gold/domain/entities/index.dart';

class LocationParamModel extends LocationParamEntity {
  const LocationParamModel({required super.country, super.state});

  factory LocationParamModel.fromEntity(LocationParamEntity e) {
    return LocationParamModel(country: e.country, state: e.state);
  }

  Map<String, dynamic> toJson() {
    return {'country': country, 'state': state};
  }
}
