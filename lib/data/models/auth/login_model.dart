import 'package:papi_gold/domain/entities/index.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  /// Converts a JSON map to a [LoginModel].
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(email: json['email'], password: json['password']);
  }

  /// Converts a [LoginEntity] to a [LoginModel].
  factory LoginModel.fromEntity(LoginEntity e){
    return LoginModel(email: e.email, password: e.password);
  }

  /// Converts a [LoginModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'email': email, 'password': password};
  }
}
