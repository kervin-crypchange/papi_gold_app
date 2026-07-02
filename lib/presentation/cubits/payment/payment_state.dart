part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final String message;
  const PaymentSuccess({required this.message});
}

final class PaymentFailure extends PaymentState {
  final String message;
  const PaymentFailure({required this.message});
}
