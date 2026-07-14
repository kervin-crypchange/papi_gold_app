import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class TrackingUseCase
    implements UseCase<Either<Failure, TrackingEntity>, String> {
  @override
  Future<Either<Failure, TrackingEntity>> call({String? param}) {
    return sl<CommonRepository>().tracking(param!);
  }
}
