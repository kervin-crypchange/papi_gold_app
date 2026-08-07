import 'dart:convert';

import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/client_entity.dart';

ClientModel clientModelFromString(String str) =>
    ClientModel.fromJson(json.decode(str));

String asesorModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel extends ClientEntity {
  const ClientModel({
    super.id,
    required super.name,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.country,
    required super.state,
    required super.city,
    required super.address1,
    required super.address2,
    required super.codeZip,
    required super.receiveAdvertise,
  });

  /// Converts a [ClientModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastName,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'code_zip': codeZip,
      'receive_advertise': receiveAdvertise,
    };
  }

  /// Converts a JSON map to a [ClientModel].
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      lastName: safeString(json['lastname']),
      email: safeString(json['email']),
      phone: safeString(json['phone']),
      country: safeInt(json['country']),
      state: safeInt(json['state']),
      city: safeInt(json['city']),
      address1: safeString(json['address1'] ),
      address2: safeString(json['address2']),
      codeZip: safeString(json['code_zip']),
      receiveAdvertise: safeBool(json['receive_advertise']),
    );
  }

  /// Converts a [ClientEntity] to a [ClientModel].
  factory ClientModel.fromEntity(ClientEntity entity) {
    return ClientModel(
      id: entity.id,
      name: entity.name,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      country: entity.country,
      state: entity.state,
      city: entity.city,
      address1: entity.address1,
      address2: entity.address2,
      codeZip: entity.codeZip,
      receiveAdvertise: entity.receiveAdvertise,
    );
  }

  Map<String, dynamic> toJSon(){
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'codeZip': codeZip,
      'receiveAdvertise': receiveAdvertise,
    };
  }
}
