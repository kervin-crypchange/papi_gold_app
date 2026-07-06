import 'package:dartz/dartz.dart';
import 'package:logger/web.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
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

      final List<CountryModel> countries = res.data
          .map((x) => CountryModel.fromJson(x))
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
      final List<LocationModel> locations = res.data
          .map((x) => LocationModel.fromJson(x))
          .toList();
      return Right(locations);
    } catch (e) {
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
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseProductsModel>> productList(int page) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.product,
        queryParameters: {'page': page, 'per_page': 15},
      );
      return Right(ResponseProductsModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> productDetail(int id) async {
    try {
      final res = await sl<DioClient>().get('${Apis.product}/$id');
      return Right(ProductModel.fromJson(res.data['data']));
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseCheckOutModel>> checkout(
    CheckOutModel model,
  ) async {
    try {
      final res = await sl<DioClient>().post(Apis.order, data: model.toJson());
      debugPrint('--- $res');
      return Right(ResponseCheckOutModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseOrdersModel>> orderList(int page) async {
    try {
      final res = await sl<DioClient>().get(
        Apis.order,
        queryParameters: {'page': page, 'per_page': 15},
      );
      return Right(ResponseOrdersModel.fromJson(res.data));
    } catch (e) {
      logger.e(e);
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
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
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
      debugPrint('Payment Intent Response: ${res.data}');
      return Right(ResponsePaymentIntentModel.fromJson(res.data));
    } catch (e) {
      return Left(ServerException(e));
    }
  }
}
