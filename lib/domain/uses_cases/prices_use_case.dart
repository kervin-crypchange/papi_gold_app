import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/metal_entity.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class PricesUseCase implements UseCase<Either<Failure, List<MetalEntity>>, String?>  {

  @override
   Future<Either<Failure, List<MetalEntity>>>  call({String? param}) {
    return sl<CommonRepository>().metalList(param);
  }
}