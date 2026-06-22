import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/mixins/logger_mixin.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';
import 'package:papi_gold/presentation/cubits/ordes/orders_cubit.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with LoggerMixin {
  late MetaEntity meta;
  late List<OrderDetailEntity> orders;

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
              log('Response state $state');
              log('Response state ${state.response}');
              return OrderListWidget(
                meta: state.response.meta,
                orders: state.response.data,
              );
            }
            return Center(child: Text('Error en l carga de datos'));
          },
        ),
      ),
    );
  }
}
