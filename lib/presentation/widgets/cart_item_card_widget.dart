import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartItemCardWidget extends StatefulWidget {
  final PersistentShoppingCartItem item;
  const CartItemCardWidget({super.key, required this.item});

  @override
  State<CartItemCardWidget> createState() => _CartItemCardWidgetState();
}

class _CartItemCardWidgetState extends State<CartItemCardWidget> {
  late PersistentShoppingCartItem item;
  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10.w,
        children: [
          CachedNetworkImage(
            width: 72.w,
            imageUrl: item.productImages![0],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.productName, style: context.bodyMedium),
                Text(
                  getFormatMoney(item.totalPrice),
                  style: context.labelLarge,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async => await PersistentShoppingCart()
                    .incrementCartItemQuantity(item.productId),
                icon: Icon(Icons.add, size: 18),
              ),
              Text('${item.quantity}'),
              IconButton(
                onPressed: () async {
                  (item.quantity == 1)
                      ? await PersistentShoppingCart().removeFromCart(
                          item.productId,
                        )
                      : await PersistentShoppingCart()
                            .decrementCartItemQuantity(item.productId);
                },
                icon: Icon(Icons.remove, size: 18),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w),
    ).paddingOnly(bottom: 6.h);
  }
}
