import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRepositoryImpl extends CommonRepository {
  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    Either<Failure, List<CountryEntity>> countries =
        await sl<CommonRemoteData>().getCountries();

    return countries.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocation() {
    // TODO: implement getStates
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MetalEntity>>> getMetalList() async {
     Either<Failure, List<MetalEntity>> metals =
        await sl<CommonRemoteData>().getMetalList();

    return metals.fold((l) => Left(l), (r) => Right(r));
  }
}
