import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const FilledButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return FilledButton(onPressed: onPressed, child: Text(title));
    }
    return CupertinoButton.filled(onPressed: onPressed, child: Text(title));
  }
}