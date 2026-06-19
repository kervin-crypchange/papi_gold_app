import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

class OrderListWidget extends StatelessWidget {
  final MetaEntity meta;
  final List<OrderDetailEntity> orders;

  const OrderListWidget({super.key, required this.meta, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => Gap(12.h),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final OrderDetailEntity order = orders[index];
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.white12,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Controls the roundness
                ),
                child: const Icon(Icons.share, color: AppColors.secondary),
              ),
              title: Row(
                spacing: 8.w,
                children: [
                  Text(order.invoice, style: context.bodySmall).medium,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      order.status.name,
                      style: context.bodyXSmall,
                    ).paddingSymmetric(horizontal: 6.w, vertical: 1.h),
                  ),
                ],
              ),
              subtitle: Row(
                spacing: 6.w,
                children: [
                  Text('Monto total: '),
                  Text(
                    getFormatMoney(order.total),
                    style: context.bodyMedium.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 12.w);
          },
        ),
      ),
    );
  }
}
