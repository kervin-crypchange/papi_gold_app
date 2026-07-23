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
  Future<Either<Failure, void>> create(DirectionEntity direction) async {
    final DirectionModel model = DirectionModel.fromEntity(direction);
    Either<Failure, void> res = await sl<DirectionRemoteData>().create(model);
    return res.fold((l) => Left(l), (r) => Right(null));
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    Either<Failure, void> res = await sl<DirectionRemoteData>().delete(id);
    return res.fold((l) => Left(l), (r) => Right(null));
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
    DirectionEntity body,
  ) async {
    final DirectionModel model = DirectionModel.fromEntity(body);

    Either<Failure, DirectionEntity> res = await sl<DirectionRemoteData>()
        .update( model);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
