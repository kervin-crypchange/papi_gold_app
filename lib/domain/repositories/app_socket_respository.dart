import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/index.dart';

abstract class AppSocketRespository {
  Future<Either<Failure, void>> connect(AppSocketsEnum event);
  Future<Either<Failure, void>> disconnect(AppSocketsEnum event);
  Stream<Either<Failure, String>> getMessages();
}
