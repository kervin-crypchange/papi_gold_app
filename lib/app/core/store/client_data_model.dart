import 'package:hive/hive.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

@HiveType(typeId: 0)
class PersistentClientDataModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final int country;

  @HiveField(6)
  final int state;

  @HiveField(7)
  final int city;

  @HiveField(8)
  final String address1;

  @HiveField(9)
  final String address2;

  @HiveField(10)
  final String codeZip;

  @HiveField(11)
  final bool receiveAdvertise;

  @HiveField(12)
  int get key => id;

  PersistentClientDataModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.address1,
    required this.address2,
    required this.codeZip,
    required this.receiveAdvertise,
  });

  factory PersistentClientDataModel.fromJson(Map<String, dynamic> json) {
    return PersistentClientDataModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      lastName: safeString(json['lastName']),
      email: safeString(json['email']),
      phone: safeString(json['phone']),
      country: safeInt(json['country']),
      state: safeInt(json['state']),
      city: safeInt(json['city']),
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      codeZip: safeString(json['codeZip']),
      receiveAdvertise: safeBool(json['receiveAdvertise']),
    );
  }

  Map<String, dynamic> toJson() {
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
