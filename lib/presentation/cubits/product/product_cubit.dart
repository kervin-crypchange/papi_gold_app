import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

    Future<Either<Failure, ResponseProductsEntity>> list(int page) async {
    return await sl<ProductsUseCase>().call(param: page);
  }

  void detail(int id) async {
    emit(ProductLoadding());

    Either response = await sl<ProductUseCase>().call(param: id);
    response.fold(
      (l) => emit(ProductFailure(message: l.toString())),
      (r) => emit(ProductSuccess(product: r)),
    );
  }
  
}
