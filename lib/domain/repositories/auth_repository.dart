import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/auth/recovery_entity.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseLoginEntity>> login(LoginEntity e);
  Future<Either<Failure, LogoutEntity>> logout();
  Future<Either<Failure, String>> register(RegisterEntity e);
  Future<Either<Failure, String>> recovery(RecoveryEntity e);
  Future<Either<Failure, String>> updatePassword(String password, String confirmPassword); 
}