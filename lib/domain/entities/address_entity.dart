import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final AddressLocationEntity country;
  final AddressLocationEntity state;
  final AddressLocationEntity city;
  final String address1;
  final String address2;
  final int zipCode;
  final bool isMain;

  const AddressEntity({
    required this.id,
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
    id,
    country,
    state,
    city,
    address1,
    address2,
    zipCode,
    isMain,
  ];
}


class AddressLocationEntity extends Equatable{
  final int id;
  final String name;

  const AddressLocationEntity({required this.id, required this.name});
  
  @override
  List<Object?> get props => [id, name];
  
}
