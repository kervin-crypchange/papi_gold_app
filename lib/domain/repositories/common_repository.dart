import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

abstract class CommonRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<LocationEntity>>> getLocation();

  Future<Either<Failure, List<MetalEntity>>> metalList(String? symbol);

  Future<Either<Failure, ResponseProductsEntity>> productList(int page);
  Future<Either<Failure, ProductEntity>> productDetail(int id);
  Future<Either<Failure, ResponseCheckOutEntity>> checkout(CheckOutEntity e);
  Future<Either<Failure, ResponseOrdersEntity>> orderList(int page);
  Future<Either<Failure, OrderDetailEntity>> orderDetail(String orderCode);

  Future<Either<Failure, ResponseChatEntity>> chat(ChatPayloadEntity e);
  Future<Either<Failure, ResponseMessageLogEntity>> chatHistory(
    String identifier,
  );

  Future<Either<Failure, String>> consultation(ConsultationPayloadEntity e);
  Future<Either<Failure, ResponsePaymentIntentEntity>> paymentIntent(String orderId);

}
