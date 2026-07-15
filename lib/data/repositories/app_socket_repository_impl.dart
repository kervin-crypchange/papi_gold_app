import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:flutter/material.dart';


class AppSocketRepositoryImpl extends AppSocketRespository {
  @override
  Future<Either<Failure, void>> connect(AppSocketsEnum event) async {
    try {
      debugPrint('--- AppSocketRepositoryImpl');
      sl<AppSocketSource>().connect(event);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, String>> getMessages() {
    throw UnimplementedError();
  }
}
