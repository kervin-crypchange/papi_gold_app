import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class BadgeWidget extends StatelessWidget {
  final String label;
  final Color color;
  const BadgeWidget({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        label,
        style: context.bodyXSmall.copyWith(color: AppColors.white),
      ).paddingSymmetric(horizontal: 8.w, vertical: 1.h),
    ).light;
  }
}
