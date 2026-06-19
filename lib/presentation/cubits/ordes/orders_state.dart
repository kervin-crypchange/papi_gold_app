part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoadding extends OrdersState {}

final class OrdersSuccess extends OrdersState {
  final ResponseOrdersEntity response;
  const OrdersSuccess({required this.response});
}

final class OrdersFailure extends OrdersState {
  final String message;
  const OrdersFailure({required this.message});
}
