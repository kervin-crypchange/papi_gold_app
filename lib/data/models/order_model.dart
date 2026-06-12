import 'package:papi_gold/data/models/cart_model.dart';
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
      client: ClientModel.fromJson(json['client']),
      confirmExistingClient: json['confirm_existing_client'],
      cart: CartModel.fromJson(json['cartItems'])
    );
  }

  /// Converts a [OrderModel] to a [CartEntity].
  factory OrderModel.fromEntity(OrderEntity e) {
    return OrderModel(
      client: e.client,
      confirmExistingClient: e.confirmExistingClient,
      cart: e.cart
    );
  }

  /// Converts a [ClientModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'clientData': ClientModel.fromJson(client as Map<String, dynamic>),
      'cartItems': OrderModel.fromJson(cart as Map<String, dynamic>),
      'confirm_existing_client': confirmExistingClient,
    };
  }
}
