import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'checkout_state.dart';

class CheckOutCubit extends Cubit<CheckoutState> {
  CheckOutCubit() : super(CheckoutInitial());

  Future<Either<Failure, ResponseCheckOutEntity>> checkout(
    CheckOutEntity e,
  ) async {
    return await sl<CheckOutUseCase>().call(param: e);
  }
}
