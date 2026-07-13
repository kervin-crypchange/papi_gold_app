import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductCard extends StatelessWidget with MessengerMixin {
  ProductCard({
    super.key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  });

  final double width, aspectRetio;
  final ProductEntity product;
  final VoidCallback onPress;

  Color get boxBgColor {
    return AppThemes.themeModeNotifier.value == ThemeMode.dark
        ? AppColors.greyLigth
        : AppColors.secondaryLigth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: boxBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imagen,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(height: 250.h, child: LoadingWidget()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(product.name, style: context.bodyMedium, maxLines: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getFormatMoney(product.price),
                  style: context.bodyMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                InkWell(
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
                      size: 14,
                    ).paddingAll(1.r),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
