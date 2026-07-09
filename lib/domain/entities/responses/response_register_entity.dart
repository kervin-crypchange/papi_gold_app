import 'package:equatable/equatable.dart';

class ResponseRegisterEntity extends Equatable {
  final String message;
  final String? status;

  const ResponseRegisterEntity({
    required this.message,
    this.status,
  });
  @override
  List<Object?> get props => [message, status];
}
