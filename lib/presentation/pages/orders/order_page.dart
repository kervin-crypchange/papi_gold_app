import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:papi_gold/presentation/widgets/courrier_tracking.dart';

class OrderPage extends StatefulWidget {
  final String orderId;
  const OrderPage({super.key, required this.orderId});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with MessengerMixin {
  final double width = 3;

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().orderDetail(widget.orderId);
  }

  void _makePayment(String order) {
    showLoading(context);
    context.read<PaymentCubit>().paymentIntent(order).then((either) {
      either.fold((failure) => null, (res) async {
        showLoading(context, false);
        await stripePayment(context, res.clientSecret);
      });
    });
  }

  void _getTracking(String tracking) {
    showLoading(context);
    context.read<TrackingCubit>().tracking(tracking).then((either) {
      either.fold((l) => null, (r) {
        showLoading(context, false);
        showModalBottomSheet<void>(
          context: context,
          builder: (context) => CourierTracking(
            history: r.history.reversed.toList(),
            status: r.status,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
        title: Text(
          'Resumen de Orden',
          style: context.titleMedium.copyWith(color: AppColors.white),
        ).medium,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.location_on_outlined, color: AppColors.white),
        //     tooltip: 'Tracking',
        //     onPressed: () {
        //       context.read<TrackingCubit>().tracking(tracking)
        //     },
        //   ),
        // ],
      ),
      body: SafeArea(
        child: BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrdersLoadding) {
              return LoadingWidget();
            }
            if (state is OrderSuccess) {
              return _buildUI(state.order).paddingAll(6.r);
            }
            return Center(child: Text('Error en la  carga de datos'));
          },
        ).paddingSymmetric(horizontal: 8.w),
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
                onPressed: e.payments.isNotEmpty
                    ? () => _showModalBottomSheet(context, e.payments)
                    : null,
                child: const Text('Ver pagos'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8.w,
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.secondary),
                  Text('Rastreo de orden', style: context.bodyLarge).medium,
                ],
              ),
              TextButton(
                onPressed: e.shippings.isNotEmpty
                    ? () => _getTracking(e.shippings[0].tracking)
                    : null,
                child: const Text('Ver'),
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
                onPressed: () => _makePayment(e.order),
              ),
            ).paddingOnly(bottom: 12.h),
        ],
      ),
    );
  }

  Widget _orderDetail(OrderDetailEntity e) {
    final List<dynamic> data = [
      _dataFormat(
        'Fecha',
        Text(
          getFormatDate(e.createdAt),
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      _dataFormat(
        'Descripción',
        Text(
          e.description,
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      _dataFormat(
        'Invoice',
        Text(
          e.invoice,
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      _dataFormat(
        'Status',
        Text(
          e.status.name,
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      _dataFormat(
        'Status del pago',
        (e.totalVenta > e.totalPagoVenta)
            ? BadgeWidget(label: 'Pendiente', color: AppColors.error)
            : BadgeWidget(label: 'Aprobado', color: AppColors.success),
      ),
      _dataFormat(
        'Número de orden',
        Text(
          e.order,
          style: context.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
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
              side: BorderSide(color: Colors.white38, width: width),
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
      _dataFormat(
        'Shipping status',
        Text(
          (s != null) ? s.status.name : 'Pending',
          style: context.bodyMedium.copyWith(color: AppColors.secondary),
        ),
      ),
      _dataFormat(
        'Shipping courrier',
        Text(
          (s != null) ? s.courier.name : '-',
          style: context.bodyMedium.copyWith(color: AppColors.secondary),
        ),
      ),
      _dataFormat(
        'Tracking number',
        Text(
          (s != null) ? s.tracking : 'No asignado',
          style: context.bodyMedium.copyWith(color: AppColors.secondary),
        ),
      ),
      _dataFormat(
        'Shipping address',
        Text(
          (s != null) ? s.address : 'Sin dirección registrada',
          style: context.bodyMedium.copyWith(color: AppColors.secondary),
        ),
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
            border: Border.all(color: AppColors.secondary, width: width),
            borderRadius: BorderRadius.circular(6.r),
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
                        border: Border.all(color: Colors.white, width: width),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Value').color(AppColors.white),
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
                          width: width,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
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
                  border: Border.all(color: AppColors.secondary, width: width),
                  borderRadius: BorderRadius.circular(6.r),
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
          ).paddingAll(6.r),
        ),
      ],
    );
  }

  Widget _dataFormat(String label, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodyMedium.copyWith(
            color: isDarkTheme ? AppColors.white : AppColors.grey,
          ),
        ),
        content,
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
            Text(label, style: context.bodyLarge).medium,
          ],
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary, width: width),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...data.map((d) => d)],
          ).paddingAll(6.r),
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
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 0.75.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Pagos')],
                ),
                Gap(12.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color: Colors.white38,
                          width: 0.5,
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 12.w, vertical: 4.h),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final p = payments[index];
                      return ListTile(
                        dense: true,
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
                      );
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 16.h),
          ),
        );
      },
    );
  }
}
