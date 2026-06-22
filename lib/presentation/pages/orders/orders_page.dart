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
    context.read<OrdersCubit>().orderList();
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
                    spacing: 12.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      statCard('Invested', stats.invested),
                      statCard('Sold', stats.sold),
                    ],
                  ),
                  Row(
                    spacing: 10.w,
                    children: [
                      Icon(Icons.schedule_rounded, color: AppColors.secondary,),
                      Text('Ordenes recientes', style: context.bodyMedium.copyWith(color: AppColors.secondary),)
                    ],
                  ),
                  Expanded(
                    child: OrderListWidget(meta: meta, orders: orders),
                  ),
                ],
              ).paddingAll(12.r);
            }
            return Center(child: Text('Error en l carga de datos'));
          },
        ),
      ),
    );
  }

  Widget statCard(String label, StatsDataEntity stat) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: AppColors.secondary, width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: context.bodyMedium.copyWith(color: AppColors.grey),),
            Text(getFormatMoney(stat.amount), style: context.titleMedium).medium,
            Text('${stat.count} orders', style: context.bodySmall),
          ],
        ).paddingAll(8.r),
      ),
    );
  }
}
