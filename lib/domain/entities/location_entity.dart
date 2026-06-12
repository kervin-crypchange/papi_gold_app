import 'package:equatable/equatable.dart';

class LocationEntity  extends Equatable{
  final int id;
  final String name;
  final String countryId;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.countryId
  });

  @override
  List<Object?> get props => [id, name, countryId];
}