import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/core/error/server_exception.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';
import 'package:papi_gold/data/sources/local/index.dart';
import 'package:papi_gold/data/sources/remote/socket/app_socket_source.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:socket_io_client/socket_io_client.dart' as client;

class AppSocketSourceImpl extends AppSocketSource {
  Logger logger = Logger();
  late client.Socket _socket;
  late StreamController<String> _messageController;

  client.Socket get socket => _socket;
  Function get emit => _socket.emit;

  @override
  Future<Either<Failure, void>> connect(AppSocketsEnum socket) async {
    final String token = sl<AuthLocalData>().getSavedToken();
    final PersistentClientDataModel pcd = PersistentClientData()
        .getClientData();
    try {
      _initializeController();
      String e;

      if (socket == AppSocketsEnum.notification ||
          socket == AppSocketsEnum.sale) {
        e = '${socket.event}.${pcd.id}';
      }
      e = socket.event;

      _socket = client.io(
        // 'wss://www.papigold.com',
        'http://192.168.100.162',
        client.OptionBuilder()
            .setTimeout(10000)
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableForceNew()
            .setAuth({'token': token})
            .setExtraHeaders({
              'x-api-key': 'cYaS7nA1IHUzuZQ42AbjPYzsiygFmegUiARPPv6t',
            })
            .build(),
      );

      _socket.onConnect((data) {
        logger.i(data);
      });

      _socket.onDisconnect((data) {
        logger.i(data);
      });

      _socket.onError((err) {
        logger.e('--- onError $err');
      });

      _socket.on('notification.received', (data) {
        logger.i('Received from event: $e data: $data');
      });

      _socket.connect();

      return const Right(null);
    } catch (e) {
      logger.e('WebSocket connection error: $e');
      return Left(ServerException(e));
    }
  }

  @override
  Stream<String> getMessages() {
    return _messageController.stream;
  }

  @override
  Future<Either<Failure, void>> disconnect(AppSocketsEnum socket) async {
    try {
      _socket.off(socket.event);
      _socket.disconnect();
      _socket.dispose();
      return Right(null);
    } catch (e) {
      logger.e('WebSocket disconnection error: $e');
      return Left(ServerException(e));
    }
  }

  void _initializeController() {
    _messageController =
        StreamController<String>.broadcast(); // Re-initialize the controller
  }
}
