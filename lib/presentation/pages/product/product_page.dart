import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/product_entity.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductPage extends StatelessWidget with MessengerMixin {
  final String id;
  ProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().detail(safeInt(id));
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocConsumer<ProductCubit, ProductState>(
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
            if (state is ProductSuccess) {
              final p = state.product;
              return InfoProduct(p: p);
            }
            return Center(child: Text('Ha ocurrido un error'));
          },
        ),
      ),
    );
  }
}

class InfoProduct extends StatelessWidget with MessengerMixin {
  final ProductEntity p;
  InfoProduct({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: CachedNetworkImage(
            imageUrl: p.imagen,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                  height: 250.h,
                  child: Center(child: CircularProgressIndicator()),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Gap(16.h),
        Expanded(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.name, style: context.bodyLarge),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.secondary.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        p.category.name.capitalizeFirst,
                        style: context.labelSmall,
                      ).paddingSymmetric(horizontal: 12.w, vertical: 1.h),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(p.description),
                Gap(16.h),
                Text(getFormatMoney(p.price), style: context.labelMedium),
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ),
        Center(
          child: SizedBox(
            width: 0.9.sw,
            child: FilledButtonWidget(
              title: 'Agregar al carrito',
              onPressed: () async {
                await PersistentShoppingCart().addToCart(
                  PersistentShoppingCartItem(
                    productId: safeString(p.id),
                    productName: p.name,
                    quantity: 1,
                    unitPrice: p.price,
                    productImages: [p.imagen],
                    productDescription: p.description,
                  ),
                );
                messenger.showSnackBar(
                  message: 'Item agregado al carrito',
                  color: AppColors.success,
                  seconds: 1,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
