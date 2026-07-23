import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class DirectionRepository {

  Future<Either<Failure, ResponseDirectionsEntity>> list();
  Future<Either<Failure, DirectionEntity>> detail(int id);
  Future<Either<Failure, DirectionEntity>> add(DirectionEntity direction);
  Future<Either<Failure, ResponseDirectionsEntity>> delete(int id);
  Future<Either<Failure, DirectionEntity>> update(int id, DirectionEntity? body);
}