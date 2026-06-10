import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/theme/index.dart';

extension WidgetExtension on Widget {
  Widget roundedBox({
    Color? bgColor = AppColors.white,
    Color? borderColor,
    double radius = 6,
    double borderWidth = 0.5,
  }) => Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius).r,
      border: Border.all(
        color: borderColor ?? AppColors.grey,
        width: borderWidth.w,
      ),
    ),
    child: this,
  );

  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value).w, child: this);

  Widget paddingOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    ).w,
    child: this,
  );

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );
}