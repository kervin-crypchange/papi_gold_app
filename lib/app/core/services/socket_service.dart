import 'dart:async';

import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/store/client/client_data_model.dart';
import 'package:papi_gold/app/core/store/client/persistent_client_data.dart';

import 'package:pusher_reverb_flutter/pusher_reverb_flutter.dart' as reverb;

class SocketService with LoggerMixin {
  static final SocketService _instance = SocketService._internal();
  late final reverb.ReverbClient client;
  final Map<String, reverb.Channel> _channels = {};
  final Map<String, reverb.ChannelEventListener> _listeners = {};
  PersistentClientDataModel get user => PersistentClientData()
      .getClientData();
  bool _isInitialized = false;
  Future<void>? _initialization;
  SocketService._internal();

  factory SocketService() => _instance;

  Future<void> init() async {
    if (_isInitialized) return;
    if (_initialization != null) return _initialization!;

    _initialization = _connect();
    try {
      await _initialization!;
    } finally {
      _initialization = null;
    }
  }

  Future<void> _connect() async {
    client = reverb.ReverbClient.instance(
      host: 'papigold.com',
      port: 443,
      authorizer: _myAuthorizer,
      useTLS: true,
      appKey: 'numgwtsytqyccouvi54w',
      // authEndpoint: '${Apis.baseUrl}broadcasting/auth',
       authEndpoint: 'https://www.papigold.com/broadcasting/auth',
      pingInterval: const Duration(seconds: 30),
      onError: (error) => logError('--- Socket error: $error'),
    );

    try {
      final connectionReady = _waitUntilConnected();
      await client.connect();
      await connectionReady;
      _isInitialized = true;
      debugPrint('--- state ${client.connectionState}');
    } catch (_) {
      _isInitialized = false;
      rethrow;
    }
  }

  Future<void> _waitUntilConnected() async {
    if (client.connectionState == reverb.ConnectionState.connected &&
        client.socketId != null) {
      return;
    }

    late final StreamSubscription<reverb.ConnectionState> subscription;
    final connected = Completer<void>();

    subscription = client.onConnectionStateChange.listen((state) {
      if (state == reverb.ConnectionState.connected && client.socketId != null) {
        if (!connected.isCompleted) connected.complete();
        } else if (state == reverb.ConnectionState.error ||
          state == reverb.ConnectionState.disconnected) {
        if (!connected.isCompleted) {
          connected.completeError(
            reverb.ConnectionException(
              'Reverb no pudo establecer la conexión con el servidor',
            ),
          );
        }
      }
    });

    try {
      if (client.connectionState == reverb.ConnectionState.connected &&
          client.socketId != null) {
        connected.complete();
      }
      await connected.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException(
          'Reverb no respondió al handshake en ws://${client.effectiveHost}:${client.effectivePort}/app/${client.appKey}. Estado: ${client.connectionState}; socketId: ${client.socketId}',
        ),
      );
    } finally {
      await subscription.cancel();
    }
  }

  Future<void> listenToPublicChannel(
    String channelName,
    String eventName,
    void Function(dynamic) onEvent,
  ) async {
    await init();
    try {
      final channel = client.subscribeToChannel(channelName);
      final key = '$channelName:$eventName';
      _unbind(key);
      void listener(String _, dynamic data) {
        onEvent(data);
      }
      channel.bind(eventName, listener);
      _channels[channelName] = channel;
      _listeners[key] = listener;
    } catch (e) {
      logError('--- Channel error: $e');
      rethrow;
    }
  }

  Future<void> listenToPrivateChannel(
    String channelName,
    String eventName,
    void Function(dynamic) onEvent,
  ) async {
    await init();
    try {
      final fullChannelName = 'private-$channelName.${user.id}';
      final channel = client.subscribeToPrivateChannel(fullChannelName);
      final key = '$fullChannelName:$eventName';
      _unbind(key);

      void listener(String _, dynamic data) {
        onEvent(data);
      }
      channel.bind(eventName, listener);
      _channels[fullChannelName] = channel;
      _listeners[key] = listener;
    } catch (e) {
      logError('--- Channel error: $e');
      rethrow;
    }
  }

  void _unbind(String key) {
    final separator = key.lastIndexOf(':');
    if (separator == -1) return;
    final channelName = key.substring(0, separator);
    final eventName = key.substring(separator + 1);
    final channel = _channels[channelName];
    final listener = _listeners.remove(key);
    if (channel != null && listener != null) {
      channel.unbind(eventName, listener);
    }
  }

  void unbindPrivateChannel(String eventName) {
    for (final key in _listeners.keys.where((key) {
      return key.endsWith(':$eventName') && key.startsWith('private-');
    }).toList()) {
      _unbind(key);
    }
  }

  void unbindPublicChannel(String eventName) {
    for (final key in _listeners.keys.where((key) {
      return key.endsWith(':$eventName') && !key.startsWith('private-');
    }).toList()) {
      _unbind(key);
    }
  }

  void disconnect() {
    if (!_isInitialized) return;
    _isInitialized = false;
    _listeners.clear();
    _channels.clear();
    client.disconnect();
  }

  Future<Map<String, String>> _myAuthorizer(
    String channelName,
    String socketId,
  ) async {
    final Box box = Hive.box(BoxEnum.config.name);
    final token = box.get(BoxEnum.config.token) as String?;
    if (token == null || token.isEmpty) {
      throw StateError('No hay un token de autenticación para Reverb');
    }
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'X-API-KEY': 'cYaS7nA1IHUzuZQ42AbjPYzsiygFmegUiARPPv6t',
    };
  }
}
