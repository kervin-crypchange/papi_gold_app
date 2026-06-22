import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/sale_entity.dart';

class ResponseCheckoutEntity extends Equatable {
  final String message;
  final SaleEntity sale;
  final List<CartItemEntity> cartItems;
  final String clientSecret;
  final String paymentId;

  const ResponseCheckoutEntity({
    required this.message,
    required this.clientSecret,
    required this.paymentId,
    required this.cartItems,
    required this.sale,
  });

  @override
  List<Object?> get props => [message, clientSecret, paymentId, cartItems, sale];
}
