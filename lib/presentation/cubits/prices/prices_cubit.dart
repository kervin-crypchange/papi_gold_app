import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/prices_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'prices_state.dart';

class PricesCubit extends Cubit<PricesState> {
  PricesCubit() : super(PricesInitial());

  void metals() async {
    emit(PricesLoading());

    Either response = await sl<PricesUseCase>().call();
    response.fold(
      (l) => emit(PricesFailure(message: l.toString())),
      (r) => emit(PricesSuccess(metals: r)),
    );
  }
}
