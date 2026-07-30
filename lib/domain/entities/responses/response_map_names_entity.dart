import 'package:equatable/equatable.dart';

class ResponseMapNamesEntity extends Equatable {
  final int countryId;
  final int stateId;
  final int cityId;
  final String address1;
  final String address2;
  final String codeZip;

  const ResponseMapNamesEntity({
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address1,
    required this.address2,
    required this.codeZip,
  });

  @override
  List<Object?> get props => [
    countryId,
    stateId,
    cityId,
    codeZip,
    address1,
    address2,
  ];
}
