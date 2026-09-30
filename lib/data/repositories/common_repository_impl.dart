import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRepositoryImpl extends CommonRepository {
  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    Either<Failure, List<CountryEntity>> countries =
        await sl<CommonRemoteData>().getCountries();

    return countries.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocation(
    LocationParamEntity p,
  ) async {
    final LocationParamModel param = LocationParamModel.fromEntity(p);
    Either<Failure, List<LocationEntity>> locations =
        await sl<CommonRemoteData>().getLocation(param);

    return locations.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<MetalEntity>>> metalList(String? symbol) async {
    Either<Failure, List<MetalEntity>> metals = await sl<CommonRemoteData>()
        .metalList(symbol);

    return metals.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseProductsEntity>> productList(int page) async {
    Either<Failure, ResponseProductsEntity> res = await sl<CommonRemoteData>()
        .productList(page);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ProductEntity>> productDetail(int id) async {
    Either<Failure, ProductEntity> res = await sl<CommonRemoteData>()
        .productDetail(id);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseCheckOutEntity>> checkout(
    CheckOutEntity e,
  ) async {
    Either<Failure, ResponseCheckOutEntity> res = await sl<CommonRemoteData>()
        .checkout(CheckOutModel.fromEntity(e));

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseOrdersEntity>> orderList(int page) async {
    Either<Failure, ResponseOrdersEntity> res = await sl<CommonRemoteData>()
        .orderList(page);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, OrderDetailEntity>> orderDetail(
    String orderCode,
  ) async {
    Either<Failure, OrderDetailEntity> res = await sl<CommonRemoteData>()
        .orderDetail(orderCode);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseChatEntity>> chat(ChatPayloadEntity e) async {
    Either<Failure, ResponseChatEntity> res = await sl<CommonRemoteData>().chat(
      ChatPayloadModel.fromEntity(e),
    );

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseMessageLogEntity>> chatHistory(
    String identifier,
  ) async {
    Either<Failure, ResponseMessageLogEntity> res = await sl<CommonRemoteData>()
        .chatHistory(identifier);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, String>> consultation(
    ConsultationPayloadEntity e,
  ) async {
    Either<Failure, String> res = await sl<CommonRemoteData>().consultation(
      ConsultationPayloadModel.fromEntity(e),
    );

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponsePaymentIntentEntity>> paymentIntent(
    String order,
  ) async {
    Either<Failure, ResponsePaymentIntentEntity> res =
        await sl<CommonRemoteData>().paymentIntent(order);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, TrackingEntity>> tracking(String tracking) async {
    Either<Failure, TrackingEntity> res = await sl<CommonRemoteData>().tracking(
      tracking,
    );
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseNotificationsEntity>> notifications(
    page,
  ) async {
    Either<Failure, ResponseNotificationsEntity> res =
        await sl<CommonRemoteData>().notifications(page);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    Either<Failure, void> res = await sl<CommonRemoteData>().markAsRead(id);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, int>> unreadCount() async {
    Either<Failure, int> res = await sl<CommonRemoteData>().unreadCount();
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
