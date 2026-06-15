import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/auth/auth_data.dart';
import 'package:papi_gold/injection_container.dart';

class AuthDataImpl extends AuthData with LoggerMixin {
  @override
  Future<Either<Failure, ResponseLoginModel>> login(LoginModel model) async {
   try {
     final res = await sl<DioClient>().post(Apis.login, data: model.toJson());
    log("---- Login DataRemote Response ${res.data['client']}");
     return Right(ResponseLoginModel.fromJson(res.data));
   } catch (e) {
    logError(e);
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
