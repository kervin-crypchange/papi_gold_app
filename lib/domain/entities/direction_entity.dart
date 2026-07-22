import 'package:equatable/equatable.dart';

class DirectionEntity extends Equatable {
  final int id;
  final String name;
  final AddressLocationEntity country;
  final AddressLocationEntity state;
  final AddressLocationEntity city;
  final String address1;
  final String address2;
  final String codeZip;
  final String type;
  final bool isMain;

  const DirectionEntity({
    required this.name,
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.address1,
    required this.address2,
    required this.codeZip,
    required this.type,
    required this.isMain,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    country,
    state,
    city,
    address1,
    address2,
    codeZip,
    type,
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
