import 'package:papi_gold/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
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
      name: json['name'] as String,
      lastName: json['lastname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      country: json['country'] as int,
      state: json['state'] as int ,
      city: json['city'] as int,
      address1: json['address1'] as String,
      address2: json['address2'] as String,
      codeZip: json['code_zip'] as String,
      receiveAdvertise: json['receive_advertise'] as bool,
    );
  }

  /// Converts a [ClientModel] to a [ClientEntity].
  factory ClientModel.fromEntity(ClientEntity entity) => ClientModel(
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
