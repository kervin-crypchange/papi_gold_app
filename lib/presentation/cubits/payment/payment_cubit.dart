import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/responses/response_payment_intent_entity.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  // void paymentIntent(String order) async {
  //   emit(PaymentLoading());

  //   Either response = await sl<PaymentUseCase>().call(param: order);

  //   response.fold(
  //     (l) => emit(PaymentFailure(message: l.toString())),
  //     (r) => emit(PaymentSuccess(response: r)),
  //   );
  // }

  Future<Either<Failure, ResponsePaymentIntentEntity>> paymentIntent(
    String order,
  ) async {
    return await sl<PaymentUseCase>().call(param: order);
  }
}
