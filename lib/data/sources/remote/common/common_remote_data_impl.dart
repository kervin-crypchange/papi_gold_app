import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/error/server_exception.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_checkout_model.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRemoteDataImpl extends CommonRemoteData {
  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    try {
      final res = await sl<DioClient>().get(Apis.countries);
      final ApiResponseModel response = ApiResponseModel<CountryModel>.fromJson(
        res.data['data'],
        CountryModel.fromJson,
      );
      final List<CountryModel> countries = response.data
          .map((x) => CountryModel.fromEntity(x))
          .toList();
      return Right(countries);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> getLocation() async {
    try {
      final res = await sl<DioClient>().get(Apis.countries);
      final ApiResponseModel response =
          ApiResponseModel<LocationModel>.fromJson(
            res.data['data'],
            LocationModel.fromJson,
          );
      final List<LocationModel> locations = response.data
          .map((x) => LocationModel.fromEntity(x))
          .toList();
      return Right(locations);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<MetalModel>>> getMetalList(String? symbol) async {
    try {
      final res = await sl<DioClient>().get(Apis.price);
      final ApiResponseModel response = ApiResponseModel<MetalModel>.fromJson(
        res.data['data'],
        MetalModel.fromJson,
      );
      final List<MetalModel> metals = response.data
          .map((x) => MetalModel.fromEntity(x))
          .toList();
      return Right(metals);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductInfoModel>>> getProductList() async {
    try {
      final res = await sl<DioClient>().get(Apis.price);
      final List<ProductInfoModel> response =
          ApiResponseModel<ProductInfoModel>.fromJson(
            res.data['data'],
            ProductInfoModel.fromJson,
          ).data;
      return Right(response);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductDetail(
    LocationParamModel params,
  ) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.price,
        queryParameters: params.toJson(),
      );
      return Right(ProductModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseCheckoutModel>> checkout(
    CheckOutModel model,
  ) async {
    try {
      final res = await sl<DioClient>().post(Apis.checkout);
      return Right(ResponseCheckoutModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }
  
  @override
  Future<Either<Failure, OrderDetailModel>> orderDetail(String orderCode) async {
     try {
      final res = await sl<DioClient>().get('${Apis.checkout}/$orderCode');
      return Right(OrderDetailModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }
  
  @override
  Future<Either<Failure, ResponseChatModel>> chat(ChatPayloadModel model) async {
    try {
      final res = await sl<DioClient>().get(Apis.chat);
      return Right(ResponseChatModel.fromJson(res.data['data']));
    } catch (e) {
      return Left(ServerException(e));
    }
  }
}
