import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void orderList(int page) async {
    emit(OrdersLoadding());

    Either response = await sl<OrdersUseCase>().call(param: page);

    response.fold(
      (l) => emit(OrdersFailure(message: l.toString())),
      (r) => emit(OrdersSuccess(response: r)),
    );
  }

  Future<Either<Failure, ResponseOrdersEntity>> orders(int page) async {
    return await sl<OrdersUseCase>().call(param: page);
  }

  void orderDetail(String id) async {
    emit(OrdersLoadding());

    Either response = await sl<OrderUseCase>().call(param: id);
    response.fold(
      (l) => emit(OrdersFailure(message: l.toString())),
      (r) => emit(OrderSuccess(order: r)),
    );
  }
}
