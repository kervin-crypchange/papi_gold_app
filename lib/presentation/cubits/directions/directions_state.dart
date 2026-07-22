part of 'directions_cubit.dart';

sealed class DirectionsState extends Equatable {
  const DirectionsState();

  @override
  List<Object> get props => [];
}

final class DirectionsInitial extends DirectionsState {}

final class DirectionsLoading extends DirectionsState {}

final class DirectionsSuccess extends DirectionsState {
  final ResponseDirectionsEntity response;

  const DirectionsSuccess({required this.response});
}

final class DirectionsFailure extends DirectionsState {
  final String message;

  const DirectionsFailure({required this.message});

}
