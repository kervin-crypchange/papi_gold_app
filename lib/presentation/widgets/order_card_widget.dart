import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order});

  final OrderDetailEntity order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 12, right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white12,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12), // Controls the roundness
        ),
        child: const Icon(Icons.share, color: AppColors.secondary),
      ),
      title: Text(order.invoice, style: context.bodySmall).medium,
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            order.status.name,
            style: context.bodyXSmall,
          ).paddingSymmetric(horizontal: 6.w, vertical: 1.h),
        ).paddingOnly(top: 3.h),
      ),
      trailing: Text(
        getFormatMoney(order.total),
        style: context.bodyLarge.copyWith(color: AppColors.secondary),
      ),
      onTap: () => context.goNamed(
        Routes.order,
        pathParameters: {'id': order.order.toString()},
      ),
    );
  }
}
