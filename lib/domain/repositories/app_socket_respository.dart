import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/index.dart';

abstract class AppSocketRespository {
  Future<Either<Failure, void>> connect(String room);
  Future<Either<Failure, void>> disconnect();
  Stream<Either<Failure, String>> getMessages();
}
