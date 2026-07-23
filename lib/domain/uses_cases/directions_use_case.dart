import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/direction_repository.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionsUseCase
    implements UseCase<Either<Failure, ResponseDirectionsEntity>, void> {
  @override
  Future<Either<Failure, ResponseDirectionsEntity>> call({void param}) {
    return sl<DirectionRepository>().list();
  }
}