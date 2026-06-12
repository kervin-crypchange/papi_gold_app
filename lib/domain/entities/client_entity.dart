import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final int country;
  final int state;
  final int city;
  final String address1;
  final String address2;
  final String codeZip;
  final bool receiveAdvertise;

  const ClientEntity({
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.address1,
    required this.address2,
    required this.codeZip,
    required this.receiveAdvertise,
  });

  @override
  List<Object?> get props => [
    name,
    lastName,
    email,
    phone,
    country,
    state,
    city,
    address1,
    address2,
    codeZip,
    receiveAdvertise,
  ];
}
