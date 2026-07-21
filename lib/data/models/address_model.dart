import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.country,
    required super.state,
    required super.city,
    required super.address1,
    required super.address2,
    required super.zipCode,
    required super.isMain,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: safeInt(json['cuntry']),
      state: safeInt(json['state']),
      city: safeInt(json['city']),
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      zipCode: safeInt(json['zip_code']),
      isMain: safeBool(json['default']),
    );
  }
  factory AddressModel.fromEntity(AddressEntity e) {
    return AddressModel(
      country: e.country,
      state: e.state,
      city: e.city,
      address1: e.address1,
      address2: e.address2,
      zipCode: e.zipCode,
      isMain: e.isMain,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'zip_code': zipCode,
      'default': isMain,
    };
  }
}
