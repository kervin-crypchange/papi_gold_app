import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';

import 'package:pusher_reverb_flutter/pusher_reverb_flutter.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late final ReverbClient client;
  late final Channel publicChannel;
  late final PrivateChannel privateChannel;
  late final PersistentClientDataModel user = PersistentClientData()
      .getClientData();
  bool _isInitialized = false;
  SocketService._internal();

  factory SocketService() => _instance;

  Future<void> init() async {
    if (_isInitialized) return;

    client = ReverbClient.instance(
      host: '192.168.100.162',
      port: 8080,
      authorizer: _myAuthorizer,
      useTLS: false,
      appKey: 'numgwtsytqyccouvi54w',
      authEndpoint: 'http://192.168.100.162:8000/api/broadcasting/auth',
    );

    await client.connect();
    debugPrint('--- state ${client.connectionState}');
    _isInitialized = true;
  }

  Future<void> listenToPublicChannel(
    String channelName,
    String eventName,
    Function(dynamic) onEvent,
  ) async {
    if (!_isInitialized) return;
    try {
      publicChannel = client.subscribeToChannel(channelName);
      await publicChannel.subscribe();

      publicChannel.bind(eventName, (eventName, data) {
        onEvent(data);
      });
    } catch (e) {
      debugPrint('--- Channel error: $e');
    }
  }

  Future<void> listenToPrivateChannel(
    String channelName,
    String eventName,
    Function(dynamic) onEvent,
  ) async {
    if (!_isInitialized) return;
    try {
      final String channel = 'private-$channelName.${user.id}';
      privateChannel = client.subscribeToPrivateChannel(channel);
      await privateChannel.subscribe();

      privateChannel.on(eventName).listen((onData) {
        debugPrint('--- listen $onData');
        onEvent(onData);
      });

      // privateChannel.bind(eventName, (eventName, data) {
      //   onEvent(data);
      // });
    } catch (e) {
      debugPrint('--- Channel error: $e');
    }
  }

  void unbindPrivateChannel(String eventName) {
    privateChannel.unbind(eventName);
  }

  void unbindPublicChannel(String eventName) {
    publicChannel.unbind(eventName);
  }

  void disconnect() {
    _isInitialized = false;
    client.disconnect();
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
