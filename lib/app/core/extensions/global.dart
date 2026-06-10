import 'package:flutter/material.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

extension GlobalX on BuildContext {
  void hideKeyboard() => FocusScope.of(this).unfocus();

  Future<T?> showModal<T>(Widget dialog) {
    return showDialog<T>(context: this, builder: (_) => dialog);
  }
}