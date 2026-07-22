import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/direcetions_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  DirectionEntity? direction;

  DirectionsCubit() : super(DirectionsInitial());

  // Future<Either<Failure, ResponseDirectionsEntity>> list() async {
  //   return await sl<DirectionsUseCase>().call();
  // }

  void list() async {
    emit(DirectionsLoading());

    Either response = await sl<DirectionsUseCase>().call();
    response.fold(
      (l) => emit(DirectionsFailure(message: l.toString())),
      (r) => emit(DirectionsSuccess(response: r)),
    );
  }
}
