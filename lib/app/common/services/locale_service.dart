import 'dart:async';

class LocaleService {
  static String? language;
  static final StreamController<String> _streamLocaleCtrl =
      StreamController.broadcast();
  static Stream<String> get localeStream => _streamLocaleCtrl.stream;

  static void setLocalStream(String locale) => _onLocaleHandler(locale);

  static Future<void> _onLocaleHandler(String locale) async {
    _streamLocaleCtrl.add(locale);
  }

  static void closeStream() {
    _streamLocaleCtrl.close();
  }
}