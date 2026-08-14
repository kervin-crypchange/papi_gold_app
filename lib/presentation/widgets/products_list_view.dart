import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/loading_widget.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductsListView extends StatelessWidget with MessengerMixin {
  ProductsListView({super.key, required this.data});

  final ProductInfoModel data;

  Color get boxBgColor {
    return AppThemes.themeModeNotifier.value == ThemeMode.dark
        ? AppColors.blackLigth
        : AppColors.secondaryLigth;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.products.length,
      separatorBuilder: (context, index) => Divider(color: AppColors.white,thickness: 0.5,),
      itemBuilder: (context, index) {
        final product = data.products[index];
        return ListTile(
          title: Text(product.name, maxLines: 2),
          subtitle: Text(
            getFormatMoney(product.price),
            style: context.bodyMedium.copyWith(color: AppColors.secondary),
          ),
          leading: CachedNetworkImage(
            width: 70.w,
            imageUrl: product.imagen,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(height: 100.h, child: LoadingWidget()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          trailing: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              await PersistentShoppingCart().addToCart(
                PersistentShoppingCartItem(
                  productId: safeString(product.id),
                  productName: product.name,
                  productDescription: product.description,
                  unitPrice: product.price,
                  quantity: 1,
                  productImages: [product.imagen],
                ),
              );
              messenger.showSnackBar(
                message: 'Item agregado al carrito',
                color: AppColors.success,
                seconds: 1,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: boxBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppThemes.themeModeNotifier.value == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.secondary,
                size: 16,
              ).paddingAll(2.r),
            ),
          ),
          onTap: () => context.goNamed(
            Routes.product,
            pathParameters: {'id': safeString(product.id)},
          ),
        );
      },
    );
  }
}
