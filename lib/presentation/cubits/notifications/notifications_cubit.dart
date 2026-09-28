
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/notifications_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<Either<Failure, ResponseNotificationsEntity>> list(int page) async {
    return await sl<NotificationsUseCase>().call(param: page);
  }
  
  Future<Either<Failure, void>> maskAsRead(String id) async {
    return await sl<NotificationMarkAsReadUseCase>().call(param: id);
  }
  
  void count() async {
    emit(NotificationsLoading());
    
    Either response = await sl<NotificationCountUseCase>().call();
   
    response.fold(
      (l) => emit(NotificationsUnreadFailure(message: l.toString())),
      (r) => emit(NotificationsUnreadSuccess(count: r)),
    );
  }
}
