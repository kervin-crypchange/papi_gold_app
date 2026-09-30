
import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class StreamMessagesUseCase
    implements UseCase<Stream<Either<Failure, String>>, void> {
  @override
  Future<Stream<Either<Failure, String>>> call({void param}) async {
    return sl<AppSocketRepository>().getMessages();
  }
}

class ConnectSocketUseCase implements UseCase<Either<Failure, void>, AppSocketsEnum> {
  @override
  Future<Either<Failure, void>> call({AppSocketsEnum? param}) async {
    return await sl<AppSocketRepository>().connect(param!);
  }
}

class DisconnectSocketUseCase implements UseCase<Either<Failure, void>, AppSocketsEnum> {
  @override
  Future<Either<Failure, void>> call({AppSocketsEnum? param}) async {
    return await sl<AppSocketRepository>().disconnect(param!);
  }
}