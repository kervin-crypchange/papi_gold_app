import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class DirectionModel extends DirectionEntity {
  const DirectionModel({
    required super.id,
    required super.country,
    required super.state,
    required super.city,
    required super.address1,
    required super.address2,
    required super.codeZip,
    required super.isMain,
    required super.name,
    required super.type,
  });

  factory DirectionModel.fromJson(Map<String, dynamic> json) {
    return DirectionModel(
      id: safeInt(json['id']),
      country: AddressLocationModel.fromJson(json['country']),
      state: AddressLocationModel.fromJson(json['state']),
      city: AddressLocationModel.fromJson(json['city']),
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      name: safeString(json['name']),
      type: safeString(json['type']),
      codeZip: safeString(json['zip_code']),
      isMain: safeBool(json['is_default']),
    );
  }
  factory DirectionModel.fromEntity(DirectionEntity e) {
    return DirectionModel(
      id: e.id,
      country: e.country,
      state: e.state,
      city: e.city,
      address1: e.address1,
      address2: e.address2,
      codeZip: e.codeZip,
      name: e.name,
      type: e.type,
      isMain: e.isMain,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country.id,
      'state': state.id,
      'city': city.id,
      'address1': address1,
      'address2': address2,
      'zip_code': codeZip,
      'name': name,
      'type': type,
      'is_default': isMain,
    };
  }
}

class AddressLocationModel extends AddressLocationEntity {
  const AddressLocationModel({required super.id, required super.name});

  factory AddressLocationModel.fromEntity(AddressLocationEntity e) {
    return AddressLocationModel(id: e.id, name: e.name);
  }

  factory AddressLocationModel.fromJson(Map<String, dynamic> json) {
    return AddressLocationModel(
      id: safeInt(json['id']),
      name: safeString(json['nane']),
    );
  }
}
