import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class CommonRemoteData {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, List<LocationModel>>> getLocation(LocationParamModel params);

  Future<Either<Failure, List<MetalModel>>> metalList(String? symbol);
  Future<Either<Failure, ResponseProductsModel>> productList(int page);
  Future<Either<Failure, ProductModel>> productDetail(int id);

  Future<Either<Failure, ResponseCheckOutModel>> checkout(CheckOutModel m);
  Future<Either<Failure, ResponseOrdersModel>> orderList(int page);
  Future<Either<Failure, OrderDetailModel>> orderDetail(String orderCode);

  Future<Either<Failure, ResponseChatModel>> chat(ChatPayloadModel model);
  Future<Either<Failure, ResponseMessageLogModel>> chatHistory(
    String identifier,
  );

  Future<Either<Failure, String>> consultation(ConsultationPayloadModel m);

  Future<Either<Failure, ResponsePaymentIntentModel>> paymentIntent(String order);
}
