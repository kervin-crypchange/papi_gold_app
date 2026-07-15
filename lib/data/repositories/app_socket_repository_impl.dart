import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/repositories/index.dart';

class AppSocketRepositoryImpl extends AppSocketRespository{
  @override
  Future<Either<Failure, void>> connect(String room) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, String>> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}