import 'dart:io';

import 'package:equatable/equatable.dart';

class ChatPayloadEntity extends Equatable {
  final String identifier;
  final String message;
  final File? file;
  final String? name;
  final String? email;
  final String? phone;
  final String? orderId;

  const ChatPayloadEntity({
    required this.identifier,
    required this.message,
    this.file,
    this.name,
    this.email,
    this.phone,
    this.orderId,
  });

  @override
  List<Object?> get props => [
    identifier,
    message,
    file,
    name,
    email,
    phone,
    orderId,
  ];
}
