import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';


class AppSocketRepositoryImpl extends AppSocketRespository {
  
  @override
  Future<Either<Failure, void>> connect(AppSocketsEnum event) async {
    try {
      sl<AppSocketSource>().connect(event);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disconnect(AppSocketsEnum event) async {
    try {
      await sl<AppSocketSource>().disconnect(event);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Stream<Either<Failure, String>> getMessages() {
      try {
      final stream = sl<AppSocketSource>().getMessages();
      return stream.map((message) => Right(message));
    } on Failure catch (e) {
      return Stream.value(Left(e));
    } catch (e) {
      return Stream.value(Left(UnknownFailure()));
    }
  }
}
