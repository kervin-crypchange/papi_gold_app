import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/widget.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class OrderListWidget extends StatelessWidget {
  final MetaEntity meta;
  final List<OrderDetailEntity> orders;

  const OrderListWidget({super.key, required this.meta, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 70.h),
      separatorBuilder: (context, index) => Divider(
        color: AppColors.secondary,
        height: 0.5.sp,
      ).paddingSymmetric(horizontal: 12.w, vertical: 4.h),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final OrderDetailEntity order = orders[index];
        return OrderCardWidget(order: order).paddingSymmetric(horizontal: 12);
      },
    );
  }
}
