import 'package:hive/hive.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

part 'client_data_model.g.dart';             

@HiveType(typeId: 1)
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
  final Map<String, dynamic> country;

  @HiveField(6)
  final Map<String, dynamic> state;

  @HiveField(7)
  final Map<String, dynamic> city;

  @HiveField(8)
  final String address1;

  @HiveField(9)
  final String address2;

  @HiveField(10)
  final String codeZip;

  @HiveField(11)
  final bool receiveAdvertise;
  
  @HiveField(12)
  final String category;

  @HiveField(13)
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
    required this.category,
  });

  factory PersistentClientDataModel.fromJson(Map<String, dynamic> json) {
    return PersistentClientDataModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
      lastName: safeString(json['lastName']),
      email: safeString(json['email']),
      phone: safeString(json['phone']),
      country: json['country'] ?? {},
      state: json['state'] ?? {},
      city: json['city'] ?? {},
      address1: safeString(json['address1']),
      address2: safeString(json['address2']),
      codeZip: safeString(json['codeZip']),
      receiveAdvertise: safeBool(json['receiveAdvertise']),
      category: safeString(json['category']),
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
      'category': category,
    };
  }

  int get countryId => safeInt(country['id']);
  int get stateId => safeInt(state['id']);
  int get cityId => safeInt(city['id']);
}
