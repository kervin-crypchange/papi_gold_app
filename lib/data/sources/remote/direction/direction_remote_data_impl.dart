import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/direction_model.dart';
import 'package:papi_gold/data/models/responses/response_direction_model.dart';
import 'package:papi_gold/data/sources/remote/direction/direction_remote_data.dart';

class DirectionRemoteDataImpl extends DirectionRemoteData {
  @override
  Future<Either<Failure, DirectionModel>> add(DirectionModel direction) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseDirectionModel>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DirectionModel>> detail(int id) {
    // TODO: implement detail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseDirectionModel>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DirectionModel>> update(int id, DirectionModel? body) {
    // TODO: implement update
    throw UnimplementedError();
  }
}