import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

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
            return OrderCardWidget(order: order);
          },
        ),
      ),
    );
  }
}


