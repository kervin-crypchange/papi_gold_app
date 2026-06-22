import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseCheckoutModel extends ResponseCheckoutEntity {
  const ResponseCheckoutModel({
    required super.message,
    required super.clientSecret,
    required super.paymentId,
    required super.cartItems,
    required super.sale,
  });

  factory ResponseCheckoutModel.fromJson(Map<String, dynamic> json) {
    return ResponseCheckoutModel(
      message: safeString(json['message']),
      clientSecret: safeString(json['clientSecret']),
      paymentId: safeString(json['paymentId']),
      cartItems: safeList<CartItemModel>(json['sale'], (x) => CartItemModel.fromJson(x)),
      sale: SaleModel.fromJson(json['sale'] as Map<String, dynamic>),
    );
  }
}
