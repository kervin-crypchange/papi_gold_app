import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/directions_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  DirectionEntity? direction;
  DirectionEntity? selected;
  List<DirectionEntity> directions = [];
  ResponseMapNamesEntity?  mapName;

  DirectionsCubit() : super(DirectionsInitial());

  void list() async {
    emit(DirectionsLoading());

    Either response = await sl<DirectionsUseCase>().call();
    response.fold(
      (l) => emit(DirectionsFailure(message: l.toString())),
      (r) => emit(DirectionsSuccess(response: r)),
    );
  }

  Future<Either<Failure, String>> delete(int id) async {
    return await sl<DeleteDirectionUseCase>().call(param: id);
  }
  
  Future<Either<Failure, void>> create(CreateUpdateDirectionEntity e) async {
    return await sl<CreateDirectionUseCase>().call(param: e);
  }
  
  Future<Either<Failure, void>> update(CreateUpdateDirectionEntity e) async {
    return await sl<UpdateDirectionUseCase>().call(param: e);
  }
  
  Future<Either<Failure, ResponseMapNamesEntity>> mapNames(GeoPoint e) async {
    return await sl<MapNamesUseCase>().call(param: e);
  }
}
