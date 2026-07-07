part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final List<LocationEntity> locations;

  const LocationSuccess({required this.locations});
}

final class LocationFailure extends LocationState {
  final String failure;
  const LocationFailure({required this.failure});
}

final class CountrySuccess extends LocationState {
  final List<CountryEntity> countries;
  const CountrySuccess({required this.countries});
}
