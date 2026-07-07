import 'package:equatable/equatable.dart';

class LocationParamEntity extends Equatable{
  final int country;
  final int? state;

  const LocationParamEntity({ required this.country, this.state});
  @override
  List<Object?> get props => [country, state];
}