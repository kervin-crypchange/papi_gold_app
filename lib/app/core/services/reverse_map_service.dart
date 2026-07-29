import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:papi_gold/app/common/utils/utils.dart';

class ReverseMapService {
  static Future<NominatimResult?> getReverseGeocoding({
    required double lat,
    required double lon,
  }) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json&accept-language=es',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          // Sustituye con el nombre de tu app o tu correo para cumplir la política de uso de Nominatim
          'User-Agent': 'MiAplicacionFlutter/1.0 (contacto@midominio.com)',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return NominatimResult.fromJson(data);
      } else {
        debugPrint('Error HTTP: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error al consultar Nominatim: $e');
      return null;
    }
  }
}

class NominatimResult {
  final String displayName;
  final String name;
  final Map<String, dynamic> address;

  NominatimResult({
    required this.name,
    required this.displayName,
    required this.address,
  });

  factory NominatimResult.fromJson(Map<String, dynamic> json) {
    return NominatimResult(
      name: safeString(json['name']),
      displayName: safeString(json['display_name']),
      address: json['address'] ?? {},
    );
  }
}
