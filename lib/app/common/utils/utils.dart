
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


int timeAvailable(double priceMin, double balance) {
  return ((balance / priceMin) * 60).toInt();
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


