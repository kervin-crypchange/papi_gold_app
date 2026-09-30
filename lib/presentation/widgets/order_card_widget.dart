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
    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 12, right: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkTheme ? AppColors.secondaryLigth : AppColors.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: isDarkTheme ? AppColors.secondary : AppColors.white,
            size: 18.r,
          ),
        ),
        title: Text(order.invoice, style: context.bodySmall).medium,
        subtitle: Text(
          formatDate(order.createdAt, true),
          style: context.bodyXSmall.copyWith(color: AppColors.secondary),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BadgeWidget(label: order.status.name, color: isDarkTheme ? AppColors.secondaryLigth: AppColors.secondary,),
            Text(
              formatMoney(order.totalVenta),
              style: context.bodySmall.copyWith(color: AppColors.secondary),
            ),
          ],
        ),
        onTap: () => context.goNamed(
          Routes.order,
          pathParameters: {'id': order.order.toString()},
        ),
      ),
    );
  }
}
