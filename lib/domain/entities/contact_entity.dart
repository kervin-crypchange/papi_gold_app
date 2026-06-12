import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String details;

  const ContactEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.details,
  });

  @override
  List<Object?> get props => [name, email, phone, details];
}
