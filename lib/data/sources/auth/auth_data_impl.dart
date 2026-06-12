import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/auth/index.dart';
import 'package:papi_gold/data/sources/auth/auth_data.dart';
import 'package:papi_gold/injection_container.dart';

class AuthDataImpl extends AuthData {
  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginModel model) async {
   try {
     final res = await sl<DioClient>().post(Apis.login, data: model.toJson());
     return Right(LoginResponseModel.fromJson(res.data));
   } catch (e) {
     return Left(ServerException(e));
   }
  }

  @override
  Future<Either<Failure, RegisterModel>> recovery(RecoveryModel model) {
    // TODO: implement recovery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RegisterModel>> register(RegisterModel model) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
