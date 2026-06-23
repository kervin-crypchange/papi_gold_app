import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/widget.dart';
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
      separatorBuilder: (context, index) => Container(
        width: 1.sw,
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.white38, width: 0.5),
        ),
      ).paddingSymmetric(horizontal: 12.w, vertical: 4.h),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final OrderDetailEntity order = orders[index];
        return OrderCardWidget(order: order).paddingSymmetric(horizontal: 12);
      },
    );
  }
}
