import 'package:equatable/equatable.dart';

class ResponseMessageLogEntity extends Equatable {
  final int id;
  final String identifier;
  final String name;
  final List<ResponseChatEntity> messages;

  const ResponseMessageLogEntity({
    required this.id,
    required this.identifier,
    required this.name,
    required this.messages,
  });

  @override
  List<Object?> get props => [id, identifier, name];
}

class ResponseChatEntity extends Equatable {
  final int id;
  final String message;
  final String? fileUrl;
  final bool isOperator;
  final DateTime createdAt;

  const ResponseChatEntity({
    required this.id,
    required this.message,
    required this.fileUrl,
    required this.isOperator,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, message, fileUrl, isOperator, createdAt];
}
