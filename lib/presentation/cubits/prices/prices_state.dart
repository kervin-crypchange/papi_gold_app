part of 'prices_cubit.dart';

sealed class PricesState extends Equatable {
  const PricesState();

  @override
  List<Object> get props => [];
}

final class PricesInitial extends PricesState {}

final class PricesLoading extends PricesState {}

final class PricesSuccess extends PricesState {
  final List<MetalEntity> metals;

  const PricesSuccess({required this.metals});
}

final class PricesFailure extends PricesState {
  final String message;

  const PricesFailure({required this.message});
}
