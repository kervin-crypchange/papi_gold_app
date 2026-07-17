import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';

abstract class AppSocketSource {
  Future<Either<Failure, void>> connect(AppSocketsEnum event);
  Future<Either<Failure, void>> disconnect(AppSocketsEnum event);
  Stream<String> getMessages();
}
