part of 'tracking_cubit.dart';

sealed class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

final class TrackingInitial extends TrackingState {}

final class TrackingLoading extends TrackingState {}

final class TrackingSuccess extends TrackingState {
  final TrackingEntity tracking;

  const TrackingSuccess({required this.tracking});
}

final class TrackingFailure extends TrackingState {
  final String message;

  const TrackingFailure({required this.message});
}
