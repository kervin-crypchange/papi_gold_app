import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/direction_model.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';
import 'package:papi_gold/domain/entities/responses/response_directions_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionRepositoryImpl extends DirectionRepository {
  @override
  Future<Either<Failure, DirectionEntity>> add(
    DirectionEntity direction,
  ) async {
    final DirectionModel model = DirectionModel.fromEntity(direction);
    Either<Failure, DirectionEntity> res = await sl<DirectionRemoteData>().add(
      model,
    );
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, DirectionEntity>> delete(int id) async {
    Either<Failure, DirectionEntity> res = await sl<DirectionRemoteData>()
        .delete(id);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, DirectionEntity>> detail(int id) async {
    Either<Failure, DirectionEntity> res = await sl<DirectionRemoteData>()
        .detail(id);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ResponseDirectionsEntity>> list() async {
    Either<Failure, ResponseDirectionsEntity> res =
        await sl<DirectionRemoteData>().list();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, DirectionEntity>> update(
    int id,
    DirectionEntity body,
  ) async {
    final DirectionModel model = DirectionModel.fromEntity(body);

    Either<Failure, DirectionEntity> res = await sl<DirectionRemoteData>()
        .update(id, model);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
