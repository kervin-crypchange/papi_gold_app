import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/checkout_entity.dart';
import 'package:papi_gold/domain/repositories/common_repository.dart';
import 'package:papi_gold/injection_container.dart';

class CheckOutUseCase
    implements UseCase<Either<Failure, String>, CheckOutEntity> {

  @override
  Future<Either<Failure, String>> call({CheckOutEntity? param}) {
    return sl<CommonRepository>().checkout(param!);
  }
}
