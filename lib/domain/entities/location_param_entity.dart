import 'package:equatable/equatable.dart';

class LocationParamEntity extends Equatable{
  final String country;
  final String? state;

  const LocationParamEntity({ required this.country, this.state});
  @override
  List<Object?> get props => [country, state];
}