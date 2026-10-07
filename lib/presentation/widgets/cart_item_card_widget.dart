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
      padding: EdgeInsets.all(8.r),
      width: 1.sw,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        spacing: 8.w,
        children: [
          CachedNetworkImage(
            width: 0.33.sw,
            imageUrl: item.productImages![0],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                  height: 250.h,
                  child: LoadingWidget(),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.productName),
                Text(item.productDescription!),
                Text(
                  formatMoney(item.unitPrice),
                  style: context.labelLarge,
                ).medium,
                Counter(item: item),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 6.h);
  }
}

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.item,
  });

  final PersistentShoppingCartItem item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: Container(
        width: 0.25.sw,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: context.accentColor,
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                (item.quantity == 1)
                    ? await PersistentShoppingCart().removeFromCart(
                        item.productId,
                      )
                    : await PersistentShoppingCart()
                          .decrementCartItemQuantity(
                            item.productId,
                          );
              },
              icon: Icon(Icons.remove, size: 18),
            ),
            Text('${item.quantity}'),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async => await PersistentShoppingCart()
                  .incrementCartItemQuantity(item.productId),
              icon: Icon(Icons.add, size: 18),
            ),
          ],
        ).paddingSymmetric(vertical: 1.h),
      ),
    );
  }
}
