import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

    void paymentIntent(int page) async {
    emit(PaymentLoading());

    Either response = await sl<PaymentUseCase>().call(param: page);

    response.fold(
      (l) => emit(PaymentFailure(message: l.toString())),
      (r) => emit(PaymentSuccess(message: r)),
    );
  }
}
