import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/country_entity.dart';
import 'package:papi_gold/domain/entities/location_entity.dart';
import 'package:papi_gold/domain/entities/location_param_entity.dart';
import 'package:papi_gold/domain/uses_cases/location_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<Either<Failure, List<CountryEntity>>> countries() async {
    return await sl<CountriesUseCase>().call();
  }

  Future<Either<Failure, List<LocationEntity>>> location(
    LocationParamEntity params,
  ) async {
    return await sl<LocationUseCase>().call(param: params);
  }
}
