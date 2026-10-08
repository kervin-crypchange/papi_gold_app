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
            color: context.isDarkTheme
                ? AppColors.secondaryLigth
                : AppColors.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: context.isDarkTheme
                ? AppColors.secondary
                : Theme.of(context).colorScheme.primary,
            size: 18.r,
          ),
        ),
        title: Text(order.invoice, style: context.bodySmall).medium,
        subtitle: Text(
          formatDate(order.createdAt, true),
          style: context.bodyXSmall.copyWith(color: context.accentColor),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BadgeWidget(
              label: order.status.name,
              color: context.isDarkTheme
                  ? AppColors.secondaryLigth
                  : Theme.of(context).colorScheme.primary,
            ),
            Text(
              formatMoney(order.totalVenta),
              style: context.bodySmall.copyWith(color: context.accentColor),
            ),
          ],
        ),
        onTap: () => context.goNamed(
          Routes.order,
          pathParameters: {'id': order.order},
        ),
      ),
    );
  }
}
