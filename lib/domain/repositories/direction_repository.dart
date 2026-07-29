import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class DirectionRepository {
  Future<Either<Failure, String>> delete(int id);
  Future<Either<Failure, DirectionEntity>> detail(int id);
  Future<Either<Failure, ResponseDirectionsEntity>> list();
  Future<Either<Failure, void>> update(CreateUpdateDirectionEntity body);
  Future<Either<Failure, void>> create(CreateUpdateDirectionEntity direction);
  Future<Either<Failure, ResponseMapNamesEntity>> mapNames(GeoPoint location);

}
