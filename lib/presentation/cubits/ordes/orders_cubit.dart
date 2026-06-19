import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void orderList() async {
    emit(OrdersLoadding());

    Either response = await sl<CommonRepository>().orderList();

    response.fold(
      (l) {
        print('Error $l');
        emit(OrdersFailure(message: 'error'));
      },
      (r) => emit(OrdersSuccess(response: r)),
    );
  }
}
