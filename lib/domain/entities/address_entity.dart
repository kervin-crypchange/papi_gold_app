import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int country;
  final int state;
  final int city;
  final String address1;
  final String address2;
  final int zipCode;
  final bool isMain;

  const AddressEntity({
    required this.country,
    required this.state,
    required this.city,
    required this.address1,
    required this.address2,
    required this.zipCode,
    required this.isMain,
  });

  @override
  List<Object?> get props => [
    country,
    state,
    city,
    address1,
    address2,
    zipCode,
    isMain,
  ];
}
