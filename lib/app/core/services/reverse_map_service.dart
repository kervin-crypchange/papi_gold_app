import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String name;
  final Map<String, dynamic> address;

  NominatimResult({required this.name, required this.address});

  factory NominatimResult.fromJson(Map<String, dynamic> json) {
    return NominatimResult(
      name: NominatimResult.nameFormat(json),
      address: json['address'] ?? {},
    );
  }

  static String nameFormat(Map<String, dynamic> json) {
    List<String> keys = json['address'].keys.toList();
    String name = json['name'].isEmpty ? '' : '${json['name']}.';

    if (keys.contains('suburb')) {
      return '$name ${json['address']['suburb']}';
    }
    if (keys.contains('town')) {
      return '$name ${json['address']['town']}, ${json['address']['quarter']}';
    }

    return json['name'];
  }
}
