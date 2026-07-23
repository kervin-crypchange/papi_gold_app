import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';

abstract class DirectionRemoteData {
  Future<Either<Failure, ResponseDirectionModel>> list();
  Future<Either<Failure, DirectionModel>> detail(int id);
  Future<Either<Failure, DirectionModel>> add(DirectionModel direction);
  Future<Either<Failure, ResponseDirectionModel>> delete(int id);
  Future<Either<Failure, DirectionModel>> update(int id, DirectionModel? body);
}