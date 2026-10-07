import 'package:flutter/services.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';

void fullScreenConfig() {
  // Habilita el modo de borde a borde nativo
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    AppThemes.systemUiOverlayStyle(AppThemes.themeModeNotifier.value),
  );
}
