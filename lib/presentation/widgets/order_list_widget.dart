import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class OrderListWidget extends StatelessWidget {
  final MetaEntity meta;
  final List<OrderDetailEntity> orders;
  final ScrollController controller;

  const OrderListWidget({
    super.key,
    required this.meta,
    required this.orders,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return (orders.isEmpty)
        ? Center(child: Text('No hay ordenes recientes', style: context.bodyLarge,))
        : ListView.separated(
            controller: controller,
            padding: EdgeInsets.only(bottom: navBarHeight(context)),
            separatorBuilder: (context, index) => Divider(
              color: AppColors.secondary,
              height: 0.5.sp,
            ).paddingSymmetric(horizontal: 12.w, vertical: 4.h),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final OrderDetailEntity order = orders[index];
              return OrderCardWidget(
                order: order,
              ).paddingSymmetric(horizontal: 12);
            },
          );
  }
}
