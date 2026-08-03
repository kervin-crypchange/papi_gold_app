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
  final String state;
  final String city;
  final String municipality;

  NominatimResult({
    required this.name,
    required this.state,
    required this.city,
    required this.municipality,
  });

  factory NominatimResult.fromJson(Map<String, dynamic> json) {
    return NominatimResult(
      name: NominatimResult.nameFormat(json),
      state: safeString(json['address']['state']),
      city: cityFormat(json),
      municipality: safeString(json['address']['county']),
    );
  }

  static String cityFormat(Map<String, dynamic> json){
    return json['address']['city'] ?? json['address']['town'];
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
