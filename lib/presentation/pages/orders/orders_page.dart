import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/logger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/cubits/order/orders_cubit.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with LoggerMixin {
  @override
  void initState() {
    super.initState();
    loadData(1);
  }

  void loadData(int page) {
    context.read<OrdersCubit>().orderList(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrdersLoadding) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is OrdersSuccess) {
              final StatsEntity stats = state.response.stats;
              final List<OrderDetailEntity> orders = state.response.data;
              final MetaEntity meta = state.response.meta;
              return Column(
                spacing: 20.h,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      statCard('Invested', stats.invested),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60, width: 0.5)
                        ),
                      ),
                      statCard('Sold', stats.sold),
                    ],
                  ).paddingAll(12.r),
                  Row(
                    spacing: 10.w,
                    children: [
                      Icon(Icons.history, color: AppColors.secondary),
                      Text(
                        'Ordenes recientes',
                        style: context.bodyLarge
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 12.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.0),
                        ),
                        border: Border(top: BorderSide(color: Colors.white38)),
                      ),
                      child: OrderListWidget(
                        meta: meta,
                        orders: orders,
                      ).paddingOnly(top: 16.h),
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 12.h);
            }
            return Center(child: Text('Error en la carga de datos'));
          },
        ),
      ),
    );
  }

  Widget statCard(String label, StatsDataEntity stat) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.bodySmall.copyWith(color: AppColors.secondary),
            ),
            Text(
              getFormatMoney(stat.amount),
              style: context.headlineSmall,
            ).light,
            Text('${stat.count} orders', style: context.bodySmall).light,
          ],
        ).paddingAll(8.r),
      ),
    );
  }
}
