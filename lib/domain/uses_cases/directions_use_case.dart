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
class DeleteDirectionUseCase
    implements UseCase<Either<Failure, void>, int> {
  @override
  Future<Either<Failure, void>> call({int? param}) {
    return sl<DirectionRepository>().delete(param!);
  }
}

class CreateDirectionUseCase
    implements UseCase<Either<Failure, void>, DirectionEntity> {
  @override
  Future<Either<Failure, void>> call({DirectionEntity? param}) {
    return sl<DirectionRepository>().create(param!);
  }
}

class UpdateDirectionUseCase
    implements UseCase<Either<Failure, void>, DirectionEntity> {
  @override
  Future<Either<Failure, void>> call({DirectionEntity? param}) {
    return sl<DirectionRepository>().update(param!);
  }
}