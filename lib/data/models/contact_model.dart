import 'package:papi_gold/domain/entities/index.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.type,
    required super.details,
  });

  /// Converts a JSON map to a [ContactModel].
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      details: json['details'],
    );
  }

  /// Converts a [ContactModel] to a [ContactEntity].
  factory ContactModel.fromEntity(ContactEntity e) {
    return ContactModel(
      name: e.name,
      email: e.email,
      phone: e.phone,
      type: e.type,
      details: e.details,
    );
  }

  /// Converts a [ContactModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'name': name,
      'email': email,
      'phone': phone,
      'type': type,
      'details': details,
    };
  }
}
