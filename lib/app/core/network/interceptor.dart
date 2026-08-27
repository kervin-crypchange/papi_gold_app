import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/class/app_navigation.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/store/client/persistent_client_data.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';
import 'package:papi_gold/injection_container.dart';

class InterceptorWrapper extends Interceptor with MessengerMixin {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );
  late final Box box;

  InterceptorWrapper() {
    box = Hive.box(BoxEnum.config.name);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final context = AppNavigation.navigatorKey.currentContext;
    final String message = errorMessageFormat(err.response?.data);

    logger.e('Error response ==> ${err.response}');

    switch (err.response?.statusCode) {
      case 401:
        // sl<AuthData>().refreshToken();
        sl<AuthLocalData>().clear();
        PersistentClientData().clearClientData();
        PersistentDirection().clear();
        context!.goNamed(Routes.login);
        handler.next(err);
        break;
      case 403:
        final bool requiresVerification =
            err.response?.data['requires_verification'] ?? false;
        if (requiresVerification == true) {
          messenger.showSnackBar(message: message, color: AppColors.error);
        }

        break;
      case 404:
        logger.e('Error 404');
        break;
      case 409:
        messenger.showSnackBar(
          message: err.response?.data['message'],
          color: AppColors.error,
        );
        handler.next(err);
        break;
      case 422:
        messenger.showSnackBar(message: message, color: AppColors.error);
        handler.next(err);
        break;
      case 500:
        messenger.showSnackBar(message: message, color: AppColors.error);
        handler.next(err);
        break;
      default:
        messenger.showSnackBar(message: message, color: AppColors.error);
        handler.next(err);
    }
    showLoading(context!, false);

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
    options.headers['X-API-KEY'] = 'cYaS7nA1IHUzuZQ42AbjPYzsiygFmegUiARPPv6t';

    logger.i('headers ==> ${options.headers}');
    logger.i('queryParameters ==> ${options.queryParameters}');
    logger.i('Bearer Token ==> $token');
    logger.i('${options.method} request ==> $requestPath');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('onResponse $response');
    return handler.next(response); // continue with the Response
  }

  String errorMessageFormat(Map<String, dynamic> data) {
    if (data.containsKey('errors')) {
      Iterable<String> errorKeys = data['errors'].keys;
      return data['errors'][errorKeys.first][0];
    }
    return data['message'];
  }
}
