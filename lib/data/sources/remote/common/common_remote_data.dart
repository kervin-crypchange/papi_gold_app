import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';

abstract class CommonRemoteData {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, List<LocationModel>>> getLocation();
  Future<Either<Failure, List<MetalModel>>> getMetalList(String? symbol);
  Future<Either<Failure, ApiResponseModel<ProductInfoModel>>> getProdutList();
  Future<Either<Failure, ProductModel>> getProductDetail(LocationParamModel params,);

}
