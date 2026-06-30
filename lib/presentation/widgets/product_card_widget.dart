import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductCardWidget extends StatelessWidget with MessengerMixin {
  final ProductEntity product;
  ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: BoxBorder.all(color: Colors.white38, width: 0.5),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(6.r),
                  topRight: Radius.circular(6.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imagen,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.bodyLarge.copyWith(color: AppColors.black),
                  ).medium,
                  Text(product.name).color(AppColors.black),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 0.3,
                      ),
                    ),
                  ).paddingSymmetric(vertical: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Precio').color(AppColors.grey),
                          Text(
                            getFormatMoney(product.price),
                            style: context.labelLarge,
                          ).medium,
                        ],
                      ),
                      IconButton.filled(
                        onPressed: () async {
                          messenger.showSnackBar(
                            message: 'Item agregado al carrito',
                            color: AppColors.success,
                            seconds: 1
                          );
                          await PersistentShoppingCart().addToCart(
                            PersistentShoppingCartItem(
                              productId: safeString(product.id),
                              productName: product.name,
                              unitPrice: product.price,
                              quantity: 1,
                              productImages: [product.imagen],
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.secondary.withValues(
                            alpha: 0.1,
                          ),
                          foregroundColor: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingAll(8.r),
            ],
          ),
          Positioned(
            top: 10.r,
            right: 10.r,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(100.w),
              ),
              child: Text(
                product.category.name,
                style: context.bodyXSmall,
              ).paddingSymmetric(horizontal: 6.w, vertical: 1.h),
            ),
          ),
        ],
      ),
    );
  }
}
