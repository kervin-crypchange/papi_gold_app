import 'package:flutter/cupertino.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:papi_gold/app/common/enums/index.dart';

import 'package:pusher_reverb_flutter/pusher_reverb_flutter.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  ReverbClient? _client;
  Channel? publicChannel;
  PrivateChannel? privateChannel;

  SocketService._internal();

  factory SocketService() => _instance;

  Future<void> init() async {
    if (_client != null) return;

    _client = ReverbClient.instance(
      host: '192.168.100.162',
      port: 8080,
      authorizer: _myAuthorizer,
      useTLS: false,
      appKey: 'numgwtsytqyccouvi54w',
      authEndpoint: 'http://192.168.100.162:8000/api/broadcasting/auth',
      onConnecting: () => debugPrint('--- Connecting to server...'),
      onConnected: (socketId) =>
          debugPrint('--- Connected! Socket ID: $socketId'),
      onReconnecting: () => debugPrint('--- Connection lost. Reconnecting...'),
      onDisconnected: () => debugPrint('--- Disconnected from server'),
      onError: (error) => debugPrint('--- Connection error: $error'),
    );

    await _client?.connect();
  }

  Future<void> listenToPublicChannel(
    String channelName,
    String eventName,
    Function(dynamic) onEvent,
  ) async {
    if (_client == null) {
      debugPrint(
        'Error: Debes llamar a init() primero antes de escuchar canales',
      );
      return;
    }

    // Suscribirse al canal (público en este ejemplo)
    publicChannel = _client!.subscribeToChannel(channelName);
    await publicChannel?.subscribe();

    // Listen for events
    publicChannel?.bind(eventName, (eventName, data) {
      onEvent(data);
    });
  }

  Future<void> listenToPrivateChannel(
    String channelName,
    String eventName,
    Function(dynamic) onEvent,
  ) async {
    if (_client == null) {
      debugPrint(
        'Error: Debes llamar a init() primero antes de escuchar canales',
      );
      return;
    }

    // Suscribirse al canal (público en este ejemplo)
    privateChannel = _client!.subscribeToPrivateChannel(channelName);
    await privateChannel?.subscribe();

    // Listen for events
    privateChannel?.bind(eventName, (eventName, data) {
      onEvent(data);
    });
  }

  void unbindPrivateChannel(String eventName) {
    privateChannel?.unbind(eventName);
  }

  void unbindPublicChannel(String eventName) {
    publicChannel?.unbind(eventName);
  }

  void disconnect() {
    _client?.disconnect();
    _client = null;
  }

  Future<Map<String, String>> _myAuthorizer(
    String channelName,
    String socketId,
  ) async {
    Box box = Hive.box(BoxEnum.config.name);
    final String token = box.get(BoxEnum.config.token);
    return {'Authorization': 'Bearer $token'};
  }
}
