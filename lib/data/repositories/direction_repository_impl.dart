import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/create_direction_entity.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';
import 'package:papi_gold/domain/entities/responses/response_directions_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionRepositoryImpl extends DirectionRepository {
  @override
  Future<Either<Failure, void>> create(
    CreateUpdateDirectionEntity direction,
  ) async {
    final CreateUpdateDirectionModel model =
        CreateUpdateDirectionModel.fromEntity(direction);
    Either<Failure, void> res = await sl<DirectionRemoteData>().create(model);
    return res.fold((l) => Left(l), (r) => Right(null));
  }

  @override
  Future<Either<Failure, String>> delete(int id) async {
    Either<Failure, String> res = await sl<DirectionRemoteData>().delete(id);
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
  Future<Either<Failure, void>> update(CreateUpdateDirectionEntity body) async {
    final CreateUpdateDirectionModel model =
        CreateUpdateDirectionModel.fromEntity(body);

    Either<Failure, void> res = await sl<DirectionRemoteData>().update(model);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
