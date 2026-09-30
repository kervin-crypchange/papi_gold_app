import 'package:flutter_test/flutter_test.dart';
import 'package:papi_gold/app/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('uses the dev environment by default', () {
      final config = AppConfig.fromEnvironment('dev');

      expect(config.environment, 'dev');
      expect(config.apiBaseUrl, isNotEmpty);
      expect(config.connectTimeout, const Duration(seconds: 15));
      expect(config.receiveTimeout, const Duration(seconds: 30));
    });

    test('maps the production environment to the production URL', () {
      final config = AppConfig.fromEnvironment('prod');

      expect(config.environment, 'prod');
      expect(config.apiBaseUrl, 'https://papigold.com/api/');
    });
  });
}
