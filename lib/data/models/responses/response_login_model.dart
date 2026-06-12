import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';

class ResponseLoginModel extends LoginResponseEntity {
  const ResponseLoginModel({
    required super.token,
    required super.client,
    required super.message,
  });

  /// Converts a JSON map to a [ResponseLoginModel].
  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      token: json['token'],
      client: ClientModel.fromJson(json['client']),
      message: json['message'],
    );
  }

  /// Converts a [ResponseLoginModel] to a [LoginResponseEntity].
  factory ResponseLoginModel.fromEntity(LoginResponseEntity entity) {
    return ResponseLoginModel(
      token: entity.token,
      client: ClientModel.fromEntity(entity.client),
      message: entity.message,
    );
  }

  /// Converts a [ResponseLoginModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return{
      'token':token,
      'client': ClientModel.fromJson(client as Map<String, dynamic>),
      'message': message
    };
  }

}
