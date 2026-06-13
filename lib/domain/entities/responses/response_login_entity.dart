import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/client_entity.dart';

class ResponseLoginEntity extends Equatable {
  final String token;
  final ClientEntity client;
  final String message;

  const ResponseLoginEntity({
    required this.token,
    required this.client,
    required this.message,
  });

  @override
  List<Object?> get props => [token, client, message];
}
