import 'package:papi_gold/data/models/cart_item_model.dart';
import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/checkout_entity.dart';

class CheckOutModel extends CheckoutEntity {
  const CheckOutModel({
    required super.client,
    required super.cart,
    required super.confirmExistingClient,
  });

  factory CheckOutModel.fromEntity(CheckoutEntity entity) {
    return CheckOutModel(
      client: entity.client,
      cart: entity.cart,
      confirmExistingClient: entity.confirmExistingClient,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientData': ClientModel.fromEntity(client).toJson(),
      "cartItems": List<CartItemModel>.from(
        cart.map((e) => CartItemModel.fromEntity(e).toJson()).toList(),
      ),
      'confirm_existing_client': confirmExistingClient,
    };
  }
}
