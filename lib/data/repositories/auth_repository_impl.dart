import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/auth/auth_data.dart';
import 'package:papi_gold/domain/entities/auth/recovery_entity.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/auth_repository.dart';
import 'package:papi_gold/injection_container.dart';

class AuthRepositoryImpl with LoggerMixin implements AuthRepository {
  @override
  Future<Either<Failure, ResponseLoginEntity>> login(LoginEntity e) async {
    Either<Failure, ResponseLoginModel> res = await sl<AuthData>().login(
      LoginModel.fromEntity(e),
    );
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseLoginEntity>> recovery(RecoveryEntity e) {
    // TODO: implement recovery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseLoginEntity>> register(LoginEntity e) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LogoutEntity>> logout() async {
    Either<Failure, LogoutEntity> res = await sl<AuthData>().logout();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, String>> updatePassword(
    String password,
    String confirmPassword,
  ) async {
    Either<Failure, String> res = await sl<AuthData>().updatePassword(
      password,
      confirmPassword,
    );
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
