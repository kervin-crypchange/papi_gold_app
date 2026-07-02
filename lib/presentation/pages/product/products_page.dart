import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:flutter_product_card/flutter_product_card.dart';

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
          return Center(child: CircularProgressIndicator.adaptive());
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
                  ...data.products.map(
                    (p) => ProductCard(
                      imageUrl: p.imagen,
                      categoryName: p.category.name,
                      productName: p.name,
                      price: p.price,
                      currency: '\$',
                      onTap: () {
                        // Handle card tap event
                      },
                      onFavoritePressed: () {
                        // Handle favorite button press
                      },
                      shortDescription: p.description,
                      // rating: 4.2,
                      // discountPercentage: 35.0,
                      // isAvailable: true,
                      // cardColor: Colors.white,
                      // textColor: Colors.black,
                      borderRadius: 8.0,
                    ),
                  ),
                  // ...data.products.map((p) => ProductCardWidget(product: p)),
                ],
              );
            },
          );
        }
        return Center(child: Text('Ha ocurrido un error'));
      },
    ).paddingSymmetric(horizontal: 12.w);
  }
}
