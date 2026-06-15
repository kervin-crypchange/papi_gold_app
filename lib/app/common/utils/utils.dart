
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getConnectedStatus(String connectStatus) {
  final Map<String, String> statusColors = {
    'Online': 'En línea',
    'Offline': 'Desconectado',
    'Busy': 'En llamada',
  };
  return statusColors[connectStatus] ?? 'Desconocido';
}

// Safe parsing helpers
bool safeBool(dynamic v, [bool fallback = false]) {
  if (v == null) return fallback;
  return v;
}

// Safe parsing helpers
int safeInt(dynamic v, [int fallback = 0]) {
  if (v == null) return fallback;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

double safeDouble(dynamic v, [double fallback = 0.0]) {
  if (v == null) return fallback;
  if (v is double) return v;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? fallback;
  return fallback;
}

String safeString(dynamic v, [String fallback = '']) {
  if (v == null) return fallback;
  return v.toString();
}

List<T> safeList<T>(dynamic v, T Function(dynamic) mapper) {
  if (v == null) return <T>[];
  if (v is Iterable) return v.map(mapper).toList().cast<T>();
  return <T>[];
}

DateTime safeDateTime(dynamic v, [DateTime? fallback]) {
  if (v == null) return fallback ?? DateTime.fromMillisecondsSinceEpoch(0);
  if (v is DateTime) return v;
  if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
  if (v is String) {
    final parsed = DateTime.tryParse(v);
    return parsed ?? (fallback ?? DateTime.fromMillisecondsSinceEpoch(0));
  }
  return fallback ?? DateTime.fromMillisecondsSinceEpoch(0);
}

String getFormatMoney(double amount) {
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  ).format(amount);
}

String getMonthByNumber(int m) {
  String month;
  switch (m) {
    case 1:
      month = 'Enero';
      break;
    case 2:
      month = 'Febrero';
      break;
    case 3:
      month = 'Marzo';
      break;
    case 4:
      month = 'Abril';
      break;
    case 5:
      month = 'Mayo';
      break;
    case 6:
      month = 'Junio';
      break;
    case 7:
      month = 'Julio';
      break;
    case 8:
      month = 'Agosto';
      break;
    case 9:
      month = 'Septiembre';
      break;
    case 10:
      month = 'Octubre';
      break;
    case 11:
      month = 'Noviembre';
      break;
    case 12:
      month = 'Diciembre';
      break;
    default:
      month = 'Invalid month number';
  }
  return month;
}

String getMonthName(int monthNumber, BuildContext context) {
  String locale = Localizations.localeOf(context).toString();
  String language = locale == 'es' ? 'es_MX' : 'en_US';
  final DateTime date = DateTime(2000, monthNumber);
  return DateFormat.MMM(language).format(date);
}


