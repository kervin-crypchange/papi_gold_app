import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.client,
    required super.cart,
    required super.confirmExistingClient,
  });

  /// Converts a JSON map to a [OrderModel].
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      client: ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      confirmExistingClient: json['confirm_existing_client'],
      cart: CartModel.fromJson(json['cartItems'] as Map<String, dynamic>),
    );
  }

  /// Converts a [Order] to a [OrderModel].
  factory OrderModel.fromEntity(OrderEntity e) {
    return OrderModel(
      client: e.client,
      confirmExistingClient: e.confirmExistingClient,
      cart: e.cart,
    );
  }

  /// Converts a [ClientModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'clientData': ClientModel.fromEntity(client).toJson(),
      'cartItems': CartModel.fromEntity(cart).toJson(),
      'confirm_existing_client': confirmExistingClient,
    };
  }
}
