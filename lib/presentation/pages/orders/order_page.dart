import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/cubits/order/orders_cubit.dart';

class OrderPage extends StatefulWidget {
  final String orderId;
  const OrderPage({super.key, required this.orderId});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().orderDetail(widget.orderId);
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
            if (state is OrderSuccess) {
              return _buildUI(state.order).paddingAll(12.r);
            }
            return Center(child: Text('Error en l carga de datos'));
          },
        ),
      ),
    );
  }

  Widget _buildUI(OrderDetailEntity e) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Resumen de Orden', style: context.titleMedium).medium,
            ],
          ),
          Gap(10.h),
          _orderDetail(e),
          Gap(10.h),
          ListView.builder(
            itemCount: e.items.length,
            itemBuilder: (context, index) {
              final OrderItemEntity item = e.items[index];
              return ListTile(
                leading: Icon(Icons.abc),
                title: Text(item.product),
                subtitle: Text(getFormatMoney(item.price)),
                trailing: Text(getFormatMoney(item.total)),
              );
            },
          ),
          Gap(10.h),
          _shippinfInfo(e.shippings),
        ],
      ),
    );
  }

  Widget _orderDetail(OrderDetailEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          spacing: 4.w,
          children: [
            Icon(Icons.inventory, color: AppColors.secondary),
            Text('Detalle de la orden', style: context.titleSmall).medium,
          ],
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dataFormat('Fecha', getFormatDate(e.createdAt)),
              _dataFormat('Descripción', e.description),
              _dataFormat('Invoice', e.invoice),
              _dataFormat('Status', e.status.name),
              _dataFormat('Número de orden', e.order),
            ],
          ).paddingAll(10.r),
        ),
      ],
    );
  }

  Widget _shippinfInfo(List<ShippingEntity> shippings) {
    final ShippingEntity? s = shippings.isNotEmpty ? shippings[0] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          spacing: 4.w,
          children: [
            Icon(Icons.local_shipping_outlined, color: AppColors.secondary),
            Text('Detalle del envío', style: context.titleSmall).medium,
          ],
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dataFormat(
                'Shipping status',
                (s != null) ? s.status.name : 'Pending',
              ),
              _dataFormat(
                'Shipping courrier',
                (s != null) ? s.courier.name : '-',
              ),
              _dataFormat(
                'Tracking number',
                (s != null) ? s.tracking : 'No asignado',
              ),
              _dataFormat(
                'Shipping address',
                (s != null) ? s.address : 'Sin dirección registrada',
              ),
            ],
          ).paddingAll(10.r),
        ),
      ],
    );
  }

  Widget _dataFormat(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.bodyMedium.copyWith(color: AppColors.grey)),
        Text(
          content,
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
