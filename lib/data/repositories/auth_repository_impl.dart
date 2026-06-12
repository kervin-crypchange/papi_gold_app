import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/auth/index.dart';
import 'package:papi_gold/data/sources/auth/auth_data.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';
import 'package:papi_gold/domain/entities/auth/recovery_entity.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';
import 'package:papi_gold/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with LoggerMixin implements AuthRepository {
  AuthData data;

  AuthRepositoryImpl({required this.data});

  @override
  Future<Either<Failure, LoginResponseEntity>> login(LoginEntity e) async {
    Either<Failure, ResponseLoginModel> res = await data.login(
      LoginModel.fromEntity(e),
    );
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> recovery(RecoveryEntity e) {
    // TODO: implement recovery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> register(LoginEntity e) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
