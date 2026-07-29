import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';

abstract class DirectionRemoteData {
  Future<Either<Failure, ResponseDirectionModel>> list();
  Future<Either<Failure, DirectionModel>> detail(int id);
  Future<Either<Failure, void>> create(CreateUpdateDirectionModel direction);
  Future<Either<Failure, String>> delete(int id);
  Future<Either<Failure, void>> update(CreateUpdateDirectionModel body);
  Future<Either<Failure, ResponseMapNamesModel>> mapNames(GeoPoint location);
}
