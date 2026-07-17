import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/error/server_exception.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_products_model.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRemoteDataImpl extends CommonRemoteData {
  final Logger logger = Logger();

  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    try {
      final res = await sl<DioClient>().get(Apis.countries);
      List<CountryModel> countries = (res.data['data'] as List)
          .map<CountryModel>((json) => CountryModel.fromJson(json))
          .toList();
      return Right(countries);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> getLocation(
    LocationParamModel params,
  ) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.location,
        queryParameters: params.toJson(),
      );
      List<LocationModel> locations = (res.data['data'] as List)
          .map<LocationModel>((json) => LocationModel.fromJson(json))
          .toList();
      return Right(locations);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<MetalModel>>> metalList(String? symbol) async {
    try {
      final res = await sl<DioClient>().get(Apis.price);
      final List<MetalModel> metals = res.data.map(
        (x) => MetalModel.fromJson(x),
      );
      return Right(metals);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseProductsModel>> productList(int page) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.product,
        queryParameters: {'page': page, 'per_page': 10},
      );
      return Right(ResponseProductsModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> productDetail(int id) async {
    try {
      final res = await sl<DioClient>().get('${Apis.product}/$id');
      return Right(ProductModel.fromJson(res.data['data']));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseCheckOutModel>> checkout(
    CheckOutModel model,
  ) async {
    try {
      final res = await sl<DioClient>().post(Apis.order, data: model.toJson());
      return Right(ResponseCheckOutModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseOrdersModel>> orderList(int page) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.order,
        queryParameters: {'page': page, 'per_page': 10},
      );
      return Right(ResponseOrdersModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, OrderDetailModel>> orderDetail(
    String orderCode,
  ) async {
    try {
      final res = await sl<DioClient>().get('${Apis.order}/$orderCode');
      return Right(OrderDetailModel.fromJson(res.data['data']));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseChatModel>> chat(
    ChatPayloadModel model,
  ) async {
    try {
      final res = await sl<DioClient>().get(Apis.chat);
      return Right(ResponseChatModel.fromJson(res.data['data']));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseMessageLogModel>> chatHistory(
    String identifier,
  ) async {
    try {
      final res = await sl<DioClient>().get('${Apis.chat}/$identifier');
      return Right(ResponseMessageLogModel.fromJson(res.data['data']));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> consultation(
    ConsultationPayloadModel m,
  ) async {
    try {
      final res = await sl<DioClient>().get(Apis.consultation);
      return Right(res.data['message']);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponsePaymentIntentModel>> paymentIntent(
    String order,
  ) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.paymentIntent,
        data: {'sale_id': safeString(order)},
      );
      return Right(ResponsePaymentIntentModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, TrackingModel>> tracking(String tracking) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.tracking,
        queryParameters: {"trackingNumber": tracking},
      );
      return Right(TrackingModel.fromJson(res.data['data']));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }
}
