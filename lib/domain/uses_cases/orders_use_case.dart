import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class OrdersUseCase
    implements UseCase<Either<Failure, ResponseOrdersEntity>, void> {
  @override
  Future<Either<Failure, ResponseOrdersEntity>> call({void param}) {
    return sl<CommonRepository>().orderList();
  }
}

class OrderUseCase
    implements UseCase<Either<Failure, OrderDetailEntity>, String> {
  @override
  Future<Either<Failure, OrderDetailEntity>> call({String? param}) {
    return sl<CommonRepository>().orderDetail(param!);
  }
}
