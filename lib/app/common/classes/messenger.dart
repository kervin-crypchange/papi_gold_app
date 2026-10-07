import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import '../../core/extensions/global.dart' as globals;

abstract class Messenger {
  void showSnackBar(
    String message,
    {
    IconData? icon,
    int seconds = 2,
    Color color = AppColors.black,
  });
}

class MessengerImpl implements Messenger {
  @override
  void showSnackBar(
    String message,
    {
    IconData? icon,
    int seconds = 2,
    Color color = AppColors.black,
  }) {
    globals.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: icon != null
            ? Row(
                children: [
                  Icon(icon, color: AppColors.contrastingForeground(color)),
                  Gap(6.w),
                  Text(message).color(AppColors.contrastingForeground(color)),
                ],
              )
            : Text(message).color(AppColors.contrastingForeground(color)),
        duration: Duration(seconds: seconds),
        backgroundColor: color,
        behavior: SnackBarBehavior.fixed,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}
