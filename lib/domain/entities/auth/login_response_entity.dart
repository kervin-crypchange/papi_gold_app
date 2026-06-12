import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/client_entity.dart';

class LoginResponseEntity extends Equatable {
  final String token;
  final ClientEntity client;
  final String message;

  const LoginResponseEntity({
    required this.token,
    required this.client,
    required this.message,
  });

  @override
  List<Object?> get props => [token, client, message];
}
