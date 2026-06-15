import 'package:papi_gold/app/common/utils/utils.dart';
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
      name: safeString(json['name']),
      email: safeString(json['email']),
      phone: safeString(json['phone']),
      type: safeString(json['type']),
      details: safeString(json['details']),
    );
  }

  /// Converts a [ContactEntity] to a [ContactModel].
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
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'type': type,
      'details': details,
    };
  }
}
