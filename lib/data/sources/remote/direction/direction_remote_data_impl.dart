import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/direction/direction_remote_data.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionRemoteDataImpl extends DirectionRemoteData {
  @override
  Future<Either<Failure, void>> create(
    CreateUpdateDirectionModel direction,
  ) async {
    try {
      await sl<DioClient>().post(Apis.directions, data: direction.toJson());
      return Right(null);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> delete(int id) async {
    try {
      await sl<DioClient>().delete('${Apis.directions}/$id');
      return Right('Dirección eliminada');
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, DirectionModel>> detail(int id) async {
    try {
      final res = await sl<DioClient>().get('${Apis.directions}/$id');
      return Right(DirectionModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseDirectionModel>> list() async {
    try {
      final res = await sl<DioClient>().get(Apis.directions);
      return Right(ResponseDirectionModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, void>> update(CreateUpdateDirectionModel body) async {
    final Map<String, dynamic> data = body.toJson();
    try {
      await sl<DioClient>().put('${Apis.directions}/${body.id}', data: data);
      return Right(null);
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, ResponseMapNamesModel>> mapNames(
    GeoPoint location,
  ) async {
    try {
      final res = await sl<DioClient>().post(
        '${Apis.location}/map-names',
        data: location.toMap(),
      );
      return Right(ResponseMapNamesModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }
}
