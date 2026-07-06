import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with MessengerMixin {
  @override
  void initState() {
    super.initState();
    _loadData(1);
  }

  void _loadData(int page) {
    context.read<ProductCubit>().list(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          messenger.showSnackBar(
            message: state.message,
            color: AppColors.error,
          );
        }
      },
      builder: (context, state) {
        if (state is ProductLoadding) {
          return LoadingWidget();
        }
        if (state is ProductsSuccess) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 70.h),
            scrollCacheExtent: ScrollCacheExtent.viewport(1.0),
            itemCount: state.response.data.length,
            itemBuilder: (context, index) {
              final data = state.response.data[index];
              return Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: context.bodyLarge.copyWith(
                      color: AppColors.secondary,
                    ),
                  ).paddingOnly(top: 6.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: data.products.length,
                    itemBuilder: (context, index) {
                      final p = data.products[index];
                      return ProductCard(
                        product: p,
                        onPress: () => context.goNamed(
                          Routes.product,
                          pathParameters: {'id': safeString(p.id)},
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
        return Center(child: Text('Ha ocurrido un error'));
      },
    ).paddingSymmetric(horizontal: 4.w);
  }
}
