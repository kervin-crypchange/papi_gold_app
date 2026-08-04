import 'package:hive/hive.dart';
import 'package:papi_gold/app/common/utils/utils.dart';

part 'persisten_direction_model.g.dart';

@HiveType(typeId: 2)
class PersistenDirectionModel {
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
  final String type;

  @HiveField(12)
  final bool isMain;

  @HiveField(13)
  int get key => id;

  PersistenDirectionModel({
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
    required this.type,
    required this.isMain,
  });

  factory PersistenDirectionModel.fromMap(Map<String, dynamic> map) {
    return PersistenDirectionModel(
      id: safeInt(map['id']),
      name: safeString(map['name']),
      lastName: safeString(map['last_name']),
      email: safeString(map['email']),
      phone: safeString(map['phone']),
      country: map['country'] ?? {},
      state: map['state'] ?? {},
      city: map['city'] ?? {},
      address1: safeString(map['address1']),
      address2: safeString(map['address2']),
      codeZip: safeString(map['code_zip']),
      type: safeString(map['type']),
      isMain: safeBool(map['is_default']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'code_zip': codeZip,
      'type': type,
      'is_default': isMain,
    };
  }
}
