import 'package:papi_gold/domain/entities/auth/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
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
    required super.password,
    required super.passwordConfirmation,
  });

  factory RegisterModel.fromEntity(RegisterEntity e) {
    return RegisterModel(
      name: e.name,
      lastName: e.lastName,
      email: e.email,
      phone: e.phone,
      country: e.country,
      state: e.state,
      city: e.city,
      address1: e.address1,
      address2: e.address2,
      codeZip: e.codeZip,
      password: e.password,
      passwordConfirmation: e.passwordConfirmation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastname": lastName,
      "email": email,
      "phone": phone,
      "country": country,
      "state": state,
      "city": city,
      "address1": address1,
      "address2": address2,
      "code_zip": codeZip,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
