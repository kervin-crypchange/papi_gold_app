import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/address_entity.dart';
import 'package:papi_gold/domain/repositories/common_repository.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionsUseCase
    implements UseCase<Either<Failure, List<AddressEntity>>, void> {
  @override
  Future<Either<Failure, List<AddressEntity>>> call({void param}) {
    return sl<CommonRepository>().directions();
  }
}