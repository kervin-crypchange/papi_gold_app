import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/error/server_exception.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/models/responses/response_location_model.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/responses/response_metal_model.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRemoteDataImpl extends CommonRemoteData {
  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async{
     try {
      final res = await sl<DioClient>().get(Apis.countries);
      final ResponseLocationModel response = ResponseLocationModel.fromJson(
        res.data,
      );
      final List<CountryModel> countries = response.data
          .map((x) => CountryModel.fromEntity(x))
          .toList();
      return Right(countries);
    } catch (e) {
      return Left(ServerException(e));
    }
  }

   @override
  Future<Either<Failure, List<LocationModel>>> getStates() {
    // TODO: implement getStates
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<MetalModel>>> getMetalList() async{
   try {
      final res = await sl<DioClient>().get(Apis.price);
      final ResponseMetalModel response = ResponseMetalModel.fromJson(
        res.data,
      );
      final List<MetalModel> metals = response.data
          .map((x) => MetalModel.fromEntity(x))
          .toList();
      return Right(metals);
    } catch (e) {
      return Left(ServerException(e));
    }
  }
  
}
