import 'package:equatable/equatable.dart';

class ConsultationPayloadEntity extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String type;
  final String details;

  const ConsultationPayloadEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.details,
  });

  @override
  List<Object?> get props => [name, email, phone, type, details];
}
