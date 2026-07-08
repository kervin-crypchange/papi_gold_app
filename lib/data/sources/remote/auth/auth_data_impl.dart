import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
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
      Future.delayed(const Duration(seconds: 2), () async {
        await getClientData();
      });
      return Right(ResponseLoginModel.fromJson(res.data));
    } catch (e) {
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
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterModel model) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.session,
        data: model.toJson(),
      );
      return Right(res.data);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      final res = await sl<DioClient>().delete(Apis.session);
      sl<AuthLocalData>().clear();
      PersistentClientData().clearClientData();
      return Right(LogoutModel.fromJson(res));
    } catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
    UpdatePasswordModel model,
  ) async {
    try {
      debugPrint('UpdatePassword model ${model.toJson()}');
      final res = await sl<DioClient>().put(Apis.updatePassword, data: model.toJson());
      return Right(res.data['message']);
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
    } catch (e) {
      return Left(ServerException(e));
    }
  }
}
