import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/use_case/use_case.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/common_repository.dart';
import 'package:papi_gold/injection_container.dart';

class NotificationsUseCase
    implements UseCase<Either<Failure, ResponseNotificationsEntity>, int> {
  @override
  Future<Either<Failure, ResponseNotificationsEntity>> call({int? param}) {
    return sl<CommonRepository>().notifications(param!);
  }
}

class NotificationMarkAsReadUseCase
    implements UseCase<Either<Failure, void>, String> {
  @override
  Future<Either<Failure, void>> call({String? param}) {
    return sl<CommonRepository>().markAsRead(param!);
  }
}

class NotificationCountUseCase implements UseCase<Either<Failure, int>, void> {
  @override
  Future<Either<Failure, int>> call({void param}) {
    return sl<CommonRepository>().unreadCount();
  }
}
