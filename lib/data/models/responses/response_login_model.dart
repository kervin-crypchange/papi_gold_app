import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';

class ResponseLoginModel extends ResponseLoginEntity {
  const ResponseLoginModel({
    required super.token,
    required super.refreshToken,
    required super.client,
    required super.message,
  });

  /// Converts a JSON map to a [ResponseLoginModel].
  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      token: safeString(json['token']),
      refreshToken: safeString(json['refresh_token']),
      client: ClientModel.fromJson(json['client']),
      message: safeString(json['message']),
    );
  }

  /// Converts a [ResponseLoginEntity] to a [ResponseLoginModel].
  factory ResponseLoginModel.fromEntity(ResponseLoginEntity entity) {
    return ResponseLoginModel(
      token: entity.token,
      refreshToken: entity.refreshToken,
      client: entity.client,
      message: entity.message,
    );
  }

  /// Converts a [ResponseLoginModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refresh_token': refreshToken,
      'client': ClientModel.fromEntity(client).toJson(),
      'message': message,
    };
  }
}
