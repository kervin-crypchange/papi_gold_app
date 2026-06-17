import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/checkout_entity.dart';

class CheckOutModel extends CheckoutEntity {
  const CheckOutModel({
    required super.client,
    required super.cart,
    required super.confirmExistingClient,
  });

  /// Converts a JSON map to a [CheckOutModel].
  factory CheckOutModel.fromJson(Map<String, dynamic> json) {
    return CheckOutModel(
      client: ClientModel.fromJson(json['clientData'] as Map<String, dynamic>),
      confirmExistingClient: json['confirm_existing_client'],
      cart: CartModel.fromJson(json['cartItems'] as Map<String, dynamic>),
    );
  }

  /// Converts a [Order] to a [CheckOutModel].
  factory CheckOutModel.fromEntity(CheckoutEntity e) {
    return CheckOutModel(
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
