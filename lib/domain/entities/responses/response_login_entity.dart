import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/client_entity.dart';

class ResponseLoginEntity extends Equatable {
  final String token;
  final String refreshToken;
  final ClientEntity client;
  final String message;

  const ResponseLoginEntity({
    required this.token,
    required this.refreshToken,
    required this.client,
    required this.message,
  });

  @override
  List<Object?> get props => [token, refreshToken, client, message];
}
