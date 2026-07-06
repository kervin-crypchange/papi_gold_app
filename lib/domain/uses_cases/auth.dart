import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/auth_repository.dart';
import 'package:papi_gold/injection_container.dart';

class LoginUseCase
    implements UseCase<Either<Failure, ResponseLoginEntity>, LoginModel> {
  @override
  Future<Either<Failure, ResponseLoginEntity>> call({LoginEntity? param}) {
    return sl<AuthRepository>().login(param!);
  }
}
class LogoutUseCase
    implements UseCase<Either<Failure, LogoutEntity>, void> {
  @override
  Future<Either<Failure, LogoutEntity>> call({void param}) {
    return sl<AuthRepository>().logout();
  }
}
