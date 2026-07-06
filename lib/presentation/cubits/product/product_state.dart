part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoadding extends ProductState {}

final class ProductsSuccess extends ProductState {
  final ResponseProductsEntity response;
  const ProductsSuccess({required this.response});
}

final class ProductSuccess extends ProductState {
  final ProductEntity product;
  const ProductSuccess({required this.product});
}

final class ProductFailure extends ProductState {
  final String message;
  const ProductFailure({required this.message});
}
