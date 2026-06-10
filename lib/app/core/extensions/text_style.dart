import 'package:flutter/material.dart';

extension TextStyleExtension on Widget {
  Widget get bold => DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.bold),
        child: this,
      );
  Widget get medium => DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.w500),
        child: this,
      );
  Widget get normal => DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.normal),
        child: this,
      );
  Widget get light => DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.w300),
        child: this,
      );
  Widget color(Color color) => DefaultTextStyle.merge(
        style: TextStyle(color: color),
        child: this,
      );
  Widget overflowText(TextOverflow overflow) => DefaultTextStyle.merge(
        style: TextStyle(overflow: overflow),
        child: this,
      );
}