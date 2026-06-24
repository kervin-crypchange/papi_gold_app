import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void list(int page) async {
    emit(ProductLoadding());

    Either response = await sl<ProductsUseCase>().call(param: page);

    response.fold(
      (l) => emit(ProductFailure(message: l.toString())),
      (r) => emit(ProductsSuccess(response: r)),
    );
  }
  void detail(int id) async {
    emit(ProductLoadding());

    Either response = await sl<ProductUseCase>().call(param: id);
    response.fold(
      (l) => emit(ProductFailure(message: l.toString())),
      (r) => emit(Productuccess(e: r)),
    );
  }
}
