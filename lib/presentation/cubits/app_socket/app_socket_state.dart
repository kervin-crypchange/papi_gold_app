part of 'app_socket_cubit.dart';

sealed class AppSocketState extends Equatable {
  const AppSocketState();

  @override
  List<Object> get props => [];
}

final class AppSocketInitial extends AppSocketState {}

final class AppSocketConnected extends AppSocketState {}

final class AppSocketReceiveMessage extends AppSocketState {
  final String message;
  const AppSocketReceiveMessage({required this.message});
}

final class AppSocketFailure extends AppSocketState {
  final String message;
  const AppSocketFailure({required this.message});
}
