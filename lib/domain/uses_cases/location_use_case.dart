import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class CountriesUseCase
    implements UseCase<Either<Failure, List<CountryEntity>>, void> {
  @override
  Future<Either<Failure, List<CountryEntity>>> call({void param}) {
    return sl<CommonRepository>().getCountries();
  }
}

class LocationUseCase
    implements
        UseCase<Either<Failure, List<LocationEntity>>, LocationParamEntity> {
  @override
  Future<Either<Failure, List<LocationEntity>>> call({
    LocationParamEntity? param,
  }) {
    return sl<CommonRepository>().getLocation(param!);
  }
}
