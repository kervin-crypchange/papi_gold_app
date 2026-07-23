import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';
import 'package:papi_gold/domain/entities/responses/response_directions_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';

class DirectionRepositoryImpl extends DirectionRepository{
  @override
  Future<Either<Failure, DirectionEntity>> add(DirectionEntity direction) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseDirectionsEntity>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DirectionEntity>> detail(int id) {
    // TODO: implement detail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseDirectionsEntity>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DirectionEntity>> update(int id, DirectionEntity? body) {
    // TODO: implement update
    throw UnimplementedError();
  }
}