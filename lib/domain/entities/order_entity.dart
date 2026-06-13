import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class OrderEntity extends Equatable {
  final ClientEntity client;
  final CartEntity cart;
  final bool confirmExistingClient;

  const OrderEntity({
    required this.client,
    required this.cart,
    required this.confirmExistingClient,
  });

  @override
  List<Object?> get props => [client, cart, confirmExistingClient];
}
