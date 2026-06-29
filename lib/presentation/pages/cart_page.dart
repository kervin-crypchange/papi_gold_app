import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () => context.goNamed(Routes.navigation),
        ),
        title: Text('Mi carrito'),
      ),
      body: SafeArea(
        child: PersistentShoppingCart().showCartItems(
          cartItemsBuilder:
              (
                BuildContext context,
                List<PersistentShoppingCartItem> cartItems,
              ) {
                if (cartItems.isEmpty) {
                  return Text('empty cart');
                }
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      height: 90.h,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        spacing: 10.w,
                        children: [
                          // Image.network(item.productImages![0], width: 72.w),
                          CachedNetworkImage(
                            width: 72.w,
                            imageUrl: item.productImages![0],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                  height: 250,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item.productName),
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
                                onPressed: () => debugPrint('print'),
                                icon: Icon(Icons.add, size: 18),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                onPressed: () => debugPrint('print'),
                                icon: Icon(Icons.remove, size: 18),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 12.w),
                    ).paddingOnly(bottom: 6.h);
                  },
                );
              },
        ),
      ).paddingSymmetric(horizontal: 12.w),
      persistentFooterButtons: [
        PersistentShoppingCart().showTotalAmountWidget(
          cartTotalAmountWidgetBuilder: (double totalAmount) {
            return Text(
              'Total: ${getFormatMoney(totalAmount)}',
              style: context.bodyLarge,
            ).paddingOnly(right: 12.w);
          },
        ),
      ],
    );
  }
}
