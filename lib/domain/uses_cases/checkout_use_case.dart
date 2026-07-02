import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/common_repository.dart';
import 'package:papi_gold/injection_container.dart';

class CheckOutUseCase
    implements UseCase<Either<Failure, ResponseCheckOutEntity>, CheckOutEntity> {

  @override
  Future<Either<Failure, ResponseCheckOutEntity>> call({CheckOutEntity? param}) {
    return sl<CommonRepository>().checkout(param!);
  }
}
