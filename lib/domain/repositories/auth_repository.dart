import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/auth/recovery_entity.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseEntity>> login(LoginEntity e);
  Future<Either<Failure, LoginResponseEntity>> register(LoginEntity e);
  Future<Either<Failure, LoginResponseEntity>> recovery(RecoveryEntity e);
}