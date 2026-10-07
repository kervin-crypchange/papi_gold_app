import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papi_gold/app/core/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('flutter.baseflow.com/permissions/methods');
  var statusValue = 0;

  setUp(() {
    statusValue = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          switch (call.method) {
            case 'checkPermissionStatus':
              return statusValue;
            case 'requestPermissions':
              final permissions = (call.arguments as List).cast<int>();
              return {for (final permission in permissions) permission: statusValue};
            case 'openAppSettings':
              return true;
            default:
              throw MissingPluginException(
                'Unexpected permission method: ${call.method}',
              );
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('preserves detailed permission states when checking', () async {
    const expectedStatuses = {
      0: PermissionStatus.denied,
      1: PermissionStatus.granted,
      2: PermissionStatus.restricted,
      3: PermissionStatus.limited,
      4: PermissionStatus.permanentlyDenied,
      5: PermissionStatus.provisional,
    };

    for (final entry in expectedStatuses.entries) {
      statusValue = entry.key;

      final status = await PermissionService().checkPermission(
        Permission.locationWhenInUse,
      );

      expect(status, entry.value);
    }
  });

  test('returns the detailed state from a permission request', () async {
    statusValue = 4;

    final status = await PermissionService().requestPermission(
      Permission.locationWhenInUse,
    );

    expect(status, PermissionStatus.permanentlyDenied);
  });
}
