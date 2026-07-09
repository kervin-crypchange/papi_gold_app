import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_register_model.dart';

abstract class AuthData {
  Future<Either<Failure, ResponseLoginModel>> login(LoginModel model);
  Future<Either<Failure, LogoutModel>> logout();
  Future<Either<Failure, ResponseRegisterModel>> register(RegisterModel model);
  Future<Either<Failure, String>> recovery(RecoveryModel model);
    Future<Either<Failure, String>> updatePassword(UpdatePasswordModel model); 
}