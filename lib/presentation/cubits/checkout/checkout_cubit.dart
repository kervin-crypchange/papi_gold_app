import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/checkout_entity.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void checkout(CheckoutEntity e) async {
    emit(CheckoutLoading());

    Either response = await sl<CheckOutUseCase>().call(param: e);

    response.fold(
      (error) => emit(CheckoutFailure(message: error.toString())),
      (success) => emit(CheckoutSuccess(message: success)),
    );
  }
}
