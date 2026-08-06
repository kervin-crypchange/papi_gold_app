import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/store/client/client_data_model.dart';
import 'package:papi_gold/app/core/store/client/persistent_client_data.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_register_model.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';
import 'package:papi_gold/data/sources/remote/auth/auth_data.dart';
import 'package:papi_gold/injection_container.dart';

class AuthDataImpl extends AuthData with LoggerMixin {
  @override
  Future<Either<Failure, ResponseLoginModel>> login(LoginModel model) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.session,
        data: model.toJson(),
      );

      await Future.delayed(Durations.medium1, () {
        getDirections();
        getClientData();
      });
      return Right(ResponseLoginModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> recovery(RecoveryModel model) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.session,
        data: model.toJson(),
      );
      return Right(res.data);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseRegisterModel>> register(
    RegisterModel model,
  ) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.register,
        data: model.toJson(),
      );
      return Right(ResponseRegisterModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      final res = await sl<DioClient>().delete(Apis.session);
      sl<AuthLocalData>().clear();
      await PersistentClientData().clearClientData();
      PersistentDirection().clear();
      return Right(LogoutModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
    UpdatePasswordModel model,
  ) async {
    try {
      debugPrint('UpdatePassword model ${model.toJson()}');
      final res = await sl<DioClient>().put(
        Apis.updatePassword,
        data: model.toJson(),
      );
      return Right(res.data['message']);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  Future<Either<Failure, void>> getDirections() async {
    try {
      final res = await sl<DioClient>().get(Apis.directions);
      List<PersistenDirectionModel> directions = (res.data['data'] as List)
          .map((d) => PersistenDirectionModel.fromJson(d))
          .toList();

      final primaryDirection = PersistenDirectionModel.fromJson(
        res.data['primary_address'],
      );

      await PersistentDirection().addSelected(primaryDirection);
      directions.insert(0, primaryDirection);
      await PersistentDirection().addDirections(directions);
      return Right(null);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  Future<Either<Failure, void>> getClientData() async {
    try {
      final res = await sl<DioClient>().get(Apis.client);
      final clientData = PersistentClientDataModel.fromJson(res.data['data']);
      await PersistentClientData().saveClientData(clientData);
      return Right(null);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }
}
