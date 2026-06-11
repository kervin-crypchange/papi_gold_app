import 'package:logger/logger.dart';

mixin LoggerMixin {
  final Logger _logger = Logger();

  void log(String message) {
    _logger.d(message);
  }

  void logError(dynamic message) {
    _logger.e(message);
  }
}