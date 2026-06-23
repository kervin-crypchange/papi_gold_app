import 'package:logger/logger.dart';

mixin LoggerMixin {
  final Logger _logger = Logger();

  void log(dynamic message) {
    _logger.d(message);
  }

  void logError(dynamic message) {
    _logger.e(message);
  }
}