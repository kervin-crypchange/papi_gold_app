import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/app/core/theme/index.dart';
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
          Text('Resumen de Orden', style: context.titleMedium).medium,
          Text('Detalle de la orden', style: context.titleSmall).medium,
          _orderDetail(e),
        ],
      ),
    );
  }

  Widget _orderDetail(OrderDetailEntity e) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         _orderDetails('Fecha', getFormatDate(e.createdAt)),
         _orderDetails('Descripción', e.description),
         _orderDetails('Invoice', e.invoice),
         _orderDetails('Status', e.status.name),
         _orderDetails('Número de orden', e.order),
        ],
      ).paddingAll(6.r),
    );
  }

  Widget _orderDetails(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_fieldTitle(label), _fieldContent(content)],
    );
  }

  Widget _fieldTitle(String label) {
    return Text(
      label,
      style: context.bodyMedium.copyWith(color: AppColors.grey),
    );
  }

  Widget _fieldContent(String label) {
    return Text(
      label,
      style: context.bodyMedium.copyWith(color: AppColors.white),
    );
  }
}
