import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String password;

  const RegisterEntity({
    required this.email,
    required this.lastName,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [name, lastName, password, email];
}
