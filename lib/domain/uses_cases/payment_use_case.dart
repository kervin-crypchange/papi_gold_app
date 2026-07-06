import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/common_repository.dart';
import 'package:papi_gold/injection_container.dart';

class PaymentUseCase
    implements UseCase<Either<Failure, ResponsePaymentIntentEntity>, String> {
  @override
  Future<Either<Failure, ResponsePaymentIntentEntity>> call({String? param}) {
    return sl<CommonRepository>().paymentIntent(param!);
  }
}