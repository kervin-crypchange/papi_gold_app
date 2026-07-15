import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void fullScreenConfig() {
  // Habilita el modo de borde a borde nativo
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Configura los colores de las barras del sistema
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // Barra transparente
    systemNavigationBarDividerColor: Colors.transparent, // Línea divisoria transparente
    systemNavigationBarIconBrightness: Brightness.dark, // Iconos oscuros (usa Light para iconos blancos)
    
    // Opcional: También puedes configurar la barra de estado superior
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}
