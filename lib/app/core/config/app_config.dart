class AppEnvironment {
  static const String dev = 'dev';
  static const String staging = 'staging';
  static const String prod = 'prod';
}

class AppConfig {
  static AppConfig? _instance;

  final String environment;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 15),
  });

  factory AppConfig.fromEnvironment([String? environment]) {
    final env = (environment ??
            const String.fromEnvironment(
              'APP_ENV',
              defaultValue: AppEnvironment.dev,
            ))
        .toLowerCase();

    switch (env) {
      case AppEnvironment.staging:
        return const AppConfig(
          environment: AppEnvironment.staging,
          apiBaseUrl: 'https://papigold.com/api/'
        );
      case AppEnvironment.prod:
        return const AppConfig(
          environment: AppEnvironment.prod,
          apiBaseUrl: 'https://papigold.com/api/',
        );
      case AppEnvironment.dev:
      default:
        return const AppConfig(
          environment: AppEnvironment.dev,
          apiBaseUrl: 'https://papigold.com/api/',
        );
    }
  }

  static AppConfig get instance => _instance ??= AppConfig.fromEnvironment();

  static void initialize({String? environment}) {
    _instance = AppConfig.fromEnvironment(environment);
  }
}
