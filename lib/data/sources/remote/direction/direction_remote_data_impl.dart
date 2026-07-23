import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/direction_model.dart';
import 'package:papi_gold/data/models/responses/response_direction_model.dart';
import 'package:papi_gold/data/sources/remote/direction/direction_remote_data.dart';
import 'package:papi_gold/injection_container.dart';

class DirectionRemoteDataImpl extends DirectionRemoteData {
  @override
  Future<Either<Failure, DirectionModel>> create(
    DirectionModel direction,
  ) async {
    try {
      final res = await sl<DioClient>().post(
        Apis.directions,
        data: direction.toJson(),
      );
      return Right(DirectionModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }

  @override
  Future<Either<Failure, DirectionModel>> delete(int id) async {
    try {
      final res = await sl<DioClient>().delete('${Apis.directions}/$id');
      return Right(DirectionModel.fromJson(res.data['data']));
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
  Future<Either<Failure, DirectionModel>> update(DirectionModel body) async {
    try {
      final res = await sl<DioClient>().put(
        '${Apis.directions}/$id',
        data: body.toJson(),
      );
      return Right(DirectionModel.fromJson(res.data));
    } on DioException catch (e) {
      return Left(ServerException(e));
    }
  }
}
