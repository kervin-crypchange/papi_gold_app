import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/class/app_navigation.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';
import 'package:papi_gold/injection_container.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );
  late final Box box;

  LoggerInterceptor() {
    box = Hive.box(BoxEnum.config.name);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // final options = err.requestOptions;
    // final requestPath = '${options.baseUrl}${options.path}';
    switch (err.response?.statusCode) {
      case 401:
        sl<AuthLocalData>().clear();
        await PersistentClientData().clearClientData();
        // logger.i('${options.method} request ==> $requestPath'); //Info log
        try {} on DioException catch (e) {
          // If refresh fails or retry fails, navigate to login or handle as needed
          // appRouter.goNamed(Routes.login);
          handler.next(e); // Pass the error further if needed
        }
        break;
      case 403:
        final bool requiresVerification =
            err.response?.data['requires_verification'] ?? false;
        final context = AppNavigation.navigatorKey.currentContext;
        if (context != null && context.mounted) {
          if (requiresVerification == true) {
            context.goNamed(Routes.verificationRegister);
          }
        }
        break;
      case 404:
        logger.e('Error 404');
        break;
      default:
        handler.next(err); //Continue with the Error
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requestPath = '${options.baseUrl}${options.path}';
    final dynamic token = await box.get(BoxEnum.config.token);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // header para peticiones publicas sin login
    options.headers['X-API-KEY'] = 'cYaS7nA1IHUzuZQ42AbjPYzsiygFmegUiARPPv6t';

    logger.i('headers ==> ${options.headers}'); //Info log
    logger.i('queryParameters ==> ${options.queryParameters}'); //Info log
    logger.i('Bearer Token ==> $token'); //Info log
    logger.i('${options.method} request ==> $requestPath'); //Info log
    logger.i(
      '${options.method} data:${options.data} request ==> $requestPath',
    ); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    ); // Debug log
    handler.next(response); // continue with the Response
  }
}
