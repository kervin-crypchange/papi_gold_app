import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_checkout_model.dart';

abstract class CommonRemoteData {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, List<LocationModel>>> getLocation();
  Future<Either<Failure, List<MetalModel>>> getMetalList(String? symbol);
  Future<Either<Failure, List<ProductInfoModel>>> getProductList();
  Future<Either<Failure, ProductModel>> getProductDetail(LocationParamModel p);
  Future<Either<Failure, ResponseCheckoutModel>> checkout(CheckOutModel m);
  Future<Either<Failure, OrderDetailModel>> orderDetail(String orderCode);
  Future<Either<Failure, ResponseChatModel>> chat(ChatPayloadModel model);

  Future<Either<Failure, ResponseMessageLogModel>> chatHistory(String identifier);

  
}
