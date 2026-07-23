import 'package:equatable/equatable.dart';

class CreateUpdateDirectionEntity extends Equatable {
  final int? id;
  final String name;
  final int country;
  final int state;
  final int city;
  final String address1;
  final String address2;
  final String codeZip;
  final String type;
  final bool isMain;

  const CreateUpdateDirectionEntity({
    this.id,
    required this.name,
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
