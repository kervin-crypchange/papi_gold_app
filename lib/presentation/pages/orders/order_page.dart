import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
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
      appBar: AppBar(
        title: Text(
          'Resumen de Orden',
          style: context.titleMedium.copyWith(color: AppColors.white),
        ).medium,
        actions: [
          IconButton(
            icon: const Icon(Icons.payments_outlined, color: AppColors.white),
            tooltip: 'Proceder con el pago',
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
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
        spacing: 20.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8.w,
                children: [
                  Icon(Icons.credit_card_outlined, color: AppColors.secondary),
                  Text('Histórico de pagos', style: context.bodyMedium).medium,
                ],
              ),
              TextButton(
                onPressed: () => _showModalBottomSheet(context, e.payments),
                child: const Text('Ver pagos'),
              ),
            ],
          ),
          _orderDetail(e),
          _itemList(e.items),
          _shippinfInfo(e.shippings),
          _billingInfo(e),
          if (e.totalVenta > e.totalPagoVenta)
            SizedBox(
              width: 1.sw,
              child: FilledButtonWidget(
                title: 'Proceder con el pago',
                onPressed: () => print('press me'),
              ),
            ).paddingOnly(bottom: 12.h),
        ],
      ),
    );
  }

  Widget _orderDetail(OrderDetailEntity e) {
    final List<dynamic> data = [
      _dataFormat('Fecha', getFormatDate(e.createdAt)),
      _dataFormat('Descripción', e.description),
      _dataFormat('Invoice', e.invoice),
      _dataFormat('Status', e.status.name),
      _dataFormat('Número de orden', e.order),
    ];
    return _section('Detalle de la orden', Icons.inventory_outlined, data);
  }

  Widget _itemList(List<OrderItemEntity> items) {
    final double size = 50;
    final data = items
        .map(
          (i) => ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white24, width: 0.5),
            ),
            leading: Image.network(
              i.image,
              fit: BoxFit.contain,
              width: size,
              height: size,
            ),
            title: Text(
              i.product,
              style: TextStyle(color: AppColors.white),
            ).medium,
            subtitle: Text(getFormatMoney(i.price)),
            trailing: Text(getFormatMoney(i.total), style: context.bodyMedium),
          ),
        )
        .toList();
    return _section('Items de la orden', Icons.check_box_outlined, data);
  }

  Widget _shippinfInfo(List<ShippingEntity> shippings) {
    final ShippingEntity? s = shippings.isNotEmpty ? shippings[0] : null;
    final List<dynamic> data = [
      _dataFormat('Shipping status', (s != null) ? s.status.name : 'Pending'),
      _dataFormat('Shipping courrier', (s != null) ? s.courier.name : '-'),
      _dataFormat('Tracking number', (s != null) ? s.tracking : 'No asignado'),
      _dataFormat(
        'Shipping address',
        (s != null) ? s.address : 'Sin dirección registrada',
      ),
    ];
    return _section('Detalle del envío', Icons.local_shipping_outlined, data);
  }

  Widget _billingInfo(OrderDetailEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          spacing: 8.w,
          children: [
            Icon(Icons.description_outlined, color: AppColors.secondary),
            Text('Facturación', style: context.bodyMedium).medium,
          ],
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary, width: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white12, width: 0.5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Value').color(AppColors.grey),
                          Text(
                            getFormatMoney(e.totalVenta),
                          ).medium.color(AppColors.white),
                        ],
                      ).paddingAll(8.r),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.success,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Paid').color(AppColors.success),
                          Text(
                            getFormatMoney(e.totalCompra),
                          ).medium.color(AppColors.success),
                        ],
                      ).paddingAll(8.r),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary, width: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Balance Due').medium.color(AppColors.secondary),
                    Text(
                      getFormatMoney(e.totalVenta),
                    ).medium.color(AppColors.secondary),
                  ],
                ).paddingAll(8.r),
              ),
            ],
          ).paddingAll(12.r),
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

  Widget _section(String label, IconData icon, List<dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          spacing: 8.w,
          children: [
            Icon(icon, color: AppColors.secondary),
            Text(label, style: context.bodyMedium).medium,
          ],
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary, width: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...data.map((d) => d)],
          ).paddingAll(12.r),
        ),
      ],
    );
  }

  void _showModalBottomSheet(
    BuildContext context,
    List<PaymentEntity> payments,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 0.75.sh,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Pagos')],
                ),
                Gap(12.h),
                ...payments.map(
                  (p) => ListTile(
                    tileColor: Colors.white12,
                    dense: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    titleTextStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.sp,
                    ),
                    title: Text(p.type),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getFormatMoney(p.amount),
                          style: context.bodyLarge,
                        ).medium,
                        Text(
                          getFormatDate(p.createdAt, true),
                          style: context.bodyXSmall,
                        ),
                      ],
                    ),
                    trailing: Text(
                      p.status.name,
                      style: context.bodySmall.copyWith(
                        color: StatusColor.color[p.status.color],
                      ),
                    ),
                  ).paddingOnly(bottom: 12.h),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
