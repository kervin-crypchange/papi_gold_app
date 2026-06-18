import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/checkout_entity.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

abstract class CommonRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<LocationEntity>>> getLocation();
  Future<Either<Failure, List<MetalEntity>>> getMetalList(String? symbol);
  Future<Either<Failure, List<ProductInfoEntity>>> getProductList();
  Future<Either<Failure, ProductEntity>> getProductDetail(
    LocationParamEntity p,
  );
  Future<Either<Failure, ResponseCheckoutEntity>> checkout(CheckoutEntity e);
  Future<Either<Failure, OrderDetailEntity>> orderDetail(String orderCode);

  Future<Either<Failure, ResponseChatEntity>> chat(ChatPayloadEntity e);
  Future<Either<Failure, ResponseMessageLogEntity>> chatHistory(String identifier);
  
  Future<Either<Failure, String>> consultation(ConsultationPayloadEntity e);


}
