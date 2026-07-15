import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/injection_container.dart';

part 'app_socket_state.dart';

class AppSocketCubit extends Cubit<AppSocketState> {
  Logger logger = Logger();
  StreamSubscription<Either<Failure, String>>? _messagesSubscription;
  AppSocketCubit() : super(AppSocketInitial());

  Future<void> conect(AppSocketsEnum event) async {
    emit(AppSocketInitial());
    final connectionResult = await sl<ConnectSocketUseCase>().call(param: event);
    connectionResult.fold(
      (failure) =>
          emit(AppSocketFailure(message: _mapFailureToMessage(failure))),
      (_) {
        emit(AppSocketConnected());
        _startStreamingMessages();
      },
    );
  }

  void _startStreamingMessages() async {
    Stream<Either<Failure, String>> streamResult =
        await sl<StreamMessagesUseCase>().call();
    _messagesSubscription = streamResult.listen(
      (stream) {
        stream.fold((l) => emit(AppSocketFailure(message: _mapFailureToMessage(l))), (
          r,
        ) {
          emit(AppSocketReceiveMessage(message: r));
        });
      },
      onError: (error) {
        emit(AppSocketFailure(message: 'CHAT CUBIT 1: $error'));
      },
      onDone: () {
        // logger.i('Message stream closed.');
      },
    );
  }

  Future<void> disconnect() async {
    await _messagesSubscription?.cancel();
    final result = await sl<DisconnectChatUseCase>().call();
    result.fold(
      (l) => emit(AppSocketFailure(message: _mapFailureToMessage(l))),
      (r) => emit(AppSocketInitial()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerException _:
        return 'Error del servidor. Por favor, inténtalo de nuevo más tarde.';
      case NoConnectionFailure _:
        return 'No hay conexión a internet. Por favor, verifica tu conexión.';
      default:
        return 'Ha ocurrido un error inesperado. Por favor, inténtalo de nuevo.';
    }
  }

  @override
  Future<void> close() {
    disconnect();
    return super.close();
  }
}
