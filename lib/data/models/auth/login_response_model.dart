import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/auth/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    required super.token,
    required super.client,
    required super.message,
  });

  /// Converts a JSON map to a [LoginResponseModel].
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      client: ClientModel.fromJson(json['client']),
      message: json['message'],
    );
  }

  /// Converts a [LoginResponseModel] to a [LoginResponseEntity].
  factory LoginResponseModel.fromEntity(LoginResponseEntity entity) {
    return LoginResponseModel(
      token: entity.token,
      client: ClientModel.fromEntity(entity.client),
      message: entity.message,
    );
  }

  /// Converts a [LoginResponseModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'token':token,
      'client': ClientModel.fromJson(client as Map<String, dynamic>),
      'message': message
    };
  }

}
