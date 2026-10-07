part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsUnreadSuccess extends NotificationsState {
  final int count;
  const NotificationsUnreadSuccess({required this.count});

  @override
  List<Object> get props => [count];
}

final class NotificationsUnreadFailure extends NotificationsState {
  final String message;
  const NotificationsUnreadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
