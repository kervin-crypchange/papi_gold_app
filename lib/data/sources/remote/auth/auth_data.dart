import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';

abstract class AuthData {
  Future<Either<Failure, ResponseLoginModel>> login(LoginModel model);
  Future<Either<Failure, LogoutModel>> logout();
  Future<Either<Failure, RegisterModel>> register(RegisterModel model);
  Future<Either<Failure, RegisterModel>> recovery(RecoveryModel model);
    Future<Either<Failure, String>> updatePassword(String password, String confirmPassword); 
}