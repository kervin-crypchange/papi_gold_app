import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/auth/recovery_entity.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseLoginEntity>> login(LoginEntity e);
  Future<Either<Failure, LogoutEntity>> logout();
  Future<Either<Failure, ResponseLoginEntity>> register(LoginEntity e);
  Future<Either<Failure, ResponseLoginEntity>> recovery(RecoveryEntity e);
}