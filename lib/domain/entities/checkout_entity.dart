import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CheckOutEntity extends Equatable {
  final ClientEntity client;
  final List<CartItemEntity> cart;
  final bool confirmExistingClient;

  const CheckOutEntity({
    required this.client,
    required this.cart,
    required this.confirmExistingClient,
  });

  @override
  List<Object?> get props => [client, cart, confirmExistingClient];
}
