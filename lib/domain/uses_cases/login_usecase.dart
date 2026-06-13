import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';
import 'package:papi_gold/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, ResponseLoginEntity>> call(LoginEntity params) async {
    return await repository.login(params);
  }
}
