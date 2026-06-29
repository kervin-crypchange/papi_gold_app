import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class ProductsUseCase
    implements UseCase<Either<Failure, ResponseProductsEntity>, int> {
  @override
  Future<Either<Failure, ResponseProductsEntity>> call({int? param}) {
    return sl<CommonRepository>().productList(param!);
  }
}

class ProductUseCase
    implements UseCase<Either<Failure, ProductEntity>, int> {
  @override
  Future<Either<Failure, ProductEntity>> call({int? param}) {
    return sl<CommonRepository>().productDetail(param!);
  }
}
