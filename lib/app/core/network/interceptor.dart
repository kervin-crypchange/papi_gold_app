import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );
  late final Box box;

  LoggerInterceptor() {
    box = Hive.box(BoxEnum.config.name);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
   //Debug log
    if (err.response?.statusCode == 401) {
      //! Se reenvia al login pero debe cambiarse por un refresh token
      // sl<AuthLocalData>().deleteToken();
      // sl<AuthLocalData>().deleteUserLogged();
      // router.goNamed(Routes.login);
      try {} on DioException catch (e) {
        // If refresh fails or retry fails, navigate to login or handle as needed
        // appRouter.goNamed(Routes.login);
        handler.next(e); // Pass the error further if needed
      }
    }
    handler.next(err); //Continue with the Error
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

    logger.i('headers ==> ${options.headers}'); //Info log
    logger.i('queryParameters ==> ${options.queryParameters}'); //Info log
    logger.i('Bearer Token ==> $token'); //Info log
    logger.i('${options.method} request ==> $requestPath'); //Info log
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