import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
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

class _OrdersPageState extends State<OrdersPage> with MessengerMixin {
  final ScrollController _scrollController = ScrollController();
  List<OrderDetailEntity> orders = [];
  MetaEntity? meta;
  StatsEntity? stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData(1);
    _scrollController.addListener(_onScroll);
  }

  Future<void> loadData(int page) async {
    context.read<OrdersCubit>().list(page).then((either) {
      either.fold(
        (failure) => setState(() => orders = []),
        (response) => setState(() {
          meta = response.meta;
          orders.addAll(response.data);
          stats = response.stats;
          isLoading = false;
        }),
      );
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (meta!.currentPage < meta!.lastPage) {
        loadData(meta!.currentPage + 1);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Column(
            spacing: 20.h,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  statCard('Invested', stats!.invested),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60, width: 0.5),
                    ),
                  ),
                  statCard('Sold', stats!.sold),
                ],
              ).paddingAll(6.r),
              Row(
                spacing: 10.w,
                children: [
                  Icon(Icons.history, color: AppColors.secondary),
                  Text('Ordenes recientes', style: context.titleSmall),
                ],
              ).paddingSymmetric(horizontal: 12.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppThemes.themeModeNotifier.value == ThemeMode.dark
                        ? AppColors.black
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.0),
                    ),
                    border: Border(top: BorderSide(color: Colors.white38)),
                  ),
                  child: OrderListWidget(
                    controller: _scrollController,
                    meta: meta!,
                    orders: orders,
                  ).paddingOnly(top: 16.h),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 12.h);
  }

  Widget statCard(String label, StatsDataEntity stat) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.bodyLarge.copyWith(color: AppColors.secondary),
            ),
            Text(
              getFormatMoney(stat.amount),
              style: context.headlineSmall,
            ).overflowText(TextOverflow.ellipsis).medium,
            Text('${stat.count} orders', style: context.bodyMedium),
          ],
        ).paddingAll(8.r),
      ),
    );
  }
}
