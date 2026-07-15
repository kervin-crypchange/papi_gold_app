
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
    return sl<AppSocketRespository>().getMessages();
  }
}

class ConnectSocketUseCase implements UseCase<Either<Failure, void>, AppSocketsEnum> {
  @override
  Future<Either<Failure, void>> call({AppSocketsEnum? param}) async {
    return await sl<AppSocketRespository>().connect(param!);
  }
}

class DisconnectChatUseCase implements UseCase<Either<Failure, void>, void> {
  @override
  Future<Either<Failure, void>> call({void param}) async {
    return await sl<AppSocketRespository>().disconnect();
  }
}