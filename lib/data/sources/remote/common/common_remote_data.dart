import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_checkout_model.dart';
import 'package:papi_gold/data/models/responses/response_products_model.dart';

abstract class CommonRemoteData {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, List<LocationModel>>> getLocation();

  Future<Either<Failure, List<MetalModel>>> metalList(String? symbol);
  Future<Either<Failure, ResponseProductsModel>> productList();
  Future<Either<Failure, ProductModel>> productDetail(LocationParamModel p);

  Future<Either<Failure, ResponseCheckoutModel>> checkout(CheckOutModel m);
  Future<Either<Failure, ResponseOrdersModel>> orderList();
  Future<Either<Failure, OrderDetailModel>> orderDetail(String orderCode);

  Future<Either<Failure, ResponseChatModel>> chat(ChatPayloadModel model);
  Future<Either<Failure, ResponseMessageLogModel>> chatHistory(
    String identifier,
  );

  Future<Either<Failure, String>> consultation(ConsultationPayloadModel m);
}
