import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/tracking_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(TrackingInitial());

  Future<Either<Failure, TrackingEntity>> tracking(String tracking) async {
    return await sl<TrackingUseCase>().call(param: tracking);
  }
}
