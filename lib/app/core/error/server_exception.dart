import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/app/common/enums/index.dart';

class ServerException extends Equatable with LoggerMixin implements Failure  {
  final String name, message;
  final int? statusCode;
  final ServerExceptionType exceptionType;

  ServerException._({
    required this.message,
    this.exceptionType = ServerExceptionType.unexpectedError,
    int? statusCode,
  }) : statusCode = statusCode ?? 500,
       name = exceptionType.name;

  factory ServerException(dynamic error) {
    late ServerException serverException;
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.requestCancelled,
              statusCode: error.response?.statusCode,
              message: 'Request to the server has been canceled',
            );
            break;

          case DioExceptionType.connectionTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.requestTimeout,
              statusCode: error.response?.statusCode,
              message: 'Connection timeout',
            );
            break;

          case DioExceptionType.receiveTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.recieveTimeout,
              statusCode: error.response?.statusCode,
              message: 'Receive timeout',
            );
            break;

          case DioExceptionType.sendTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.sendTimeout,
              statusCode: error.response?.statusCode,
              message: 'Send timeout',
            );
            break;

          case DioExceptionType.connectionError:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.connectionError,
              message: 'Connection error',
            );
            break;

          case DioExceptionType.badCertificate:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.badCertificate,
              message: 'Bad certificate',
            );
            break;

          case DioExceptionType.unknown:
            if (error.error.toString().contains(
              ServerExceptionType.socketException.name,
            )) {
              serverException = ServerException._(
                statusCode: error.response?.statusCode,
                message: 'Verify your internet connection',
              );
            } else {
              serverException = ServerException._(
                exceptionType: ServerExceptionType.unexpectedError,
                statusCode: error.response?.statusCode,
                message: 'Unexpected error',
              );
            }
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.badRequest,
                  message: 'Bad request.',
                );
                break;
              case 401:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  message:
                      error.response?.data['message'] ??
                      'Authentication failure',
                );
                break;
              case 403:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  message: error.response?.data['message'] ?? 'User is not authorized to access API',
                );
                break;
              case 404:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.notFound,
                  message:
                      error.response?.data['message'] ??
                      'Request resource does not exist',
                );
                break;
              case 405:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  message:
                      error.response?.data['message'] ??
                      'Operation not allowed',
                );
                break;
              case 415:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.notImplemented,
                  message:
                      error.response?.data['message'] ??
                      'Media type unsupported',
                );
                break;
              case 422:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.unableToProcess,
                  message:
                      error.response?.data['message'] ??
                      'validation data failure',
                );
                break;
              case 429:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.conflict,
                  message:
                      error.response?.data['message'] ?? 'too much requests',
                );
                break;
              case 500:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.internalServerError,
                  message:
                      error.response?.data['message'] ??
                      'Internal server error',
                );
                break;
              case 503:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.serviceUnavailable,
                  message:
                      error.response?.data['message'] ?? 'Service unavailable',
                );
                break;
              default:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.unexpectedError,
                  message:
                      error.response?.data['message'] ?? 'Unexpected error',
                );
            }
            break;
          case DioExceptionType.transformTimeout:
            throw UnimplementedError();
        }
      } else {
        serverException = ServerException._(
          exceptionType: ServerExceptionType.unexpectedError,
          message: 'Unexpected error',
        );
      }
    } on FormatException catch (e) {
      serverException = ServerException._(
        exceptionType: ServerExceptionType.formatException,
        message: e.message,
      );
    } on Exception catch (_) {
      serverException = ServerException._(
        exceptionType: ServerExceptionType.unexpectedError,
        message: 'Unexpected error',
      );
    }
    return serverException;
  }

  @override
  List<Object?> get props => [name, statusCode, exceptionType];

  @override
  List get properties => throw UnimplementedError();
}