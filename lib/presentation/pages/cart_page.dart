import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/presentation/widgets/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with MessengerMixin {
 List<PersistentShoppingCartItem> _cartItems = [];
  void _checkout() {
    messenger.showSnackBar(message: 'Realizando pedido ${_cartItems.length}...', color: AppColors.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(Routes.navigation),
        ),
        title: Text('Mi carrito'),
        actions: [
          IconButton(
            onPressed: () => PersistentShoppingCart().clearCart(),
            icon: Icon(Icons.delete_forever_outlined),
            tooltip: 'Vaciar carrito',
          ),
        ],
      ),
      body: SafeArea(
        child: PersistentShoppingCart().showCartItems(
          cartItemsBuilder:
              (
                BuildContext context,
                List<PersistentShoppingCartItem> cartItems,
              ) {
                _cartItems = cartItems;
                if (cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      spacing: 12.h,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tu carrito está vacío.',
                          style: context.titleMedium,
                        ),
                        Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 52.r,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Dismissible(
                      key: ValueKey(item.productId),
                      background: Container(),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ).paddingOnly(right: 20.w),
                      ),
                      child: CartItemCardWidget(item: item),
                      onDismissed: (DismissDirection direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await PersistentShoppingCart().removeFromCart(
                            item.productId,
                          );
                        }
                      },
                    );
                  },
                );
              },
        ),
      ).paddingSymmetric(horizontal: 12.w),
      persistentFooterButtons: [
        Column(
          spacing: 12.h,
          children: [
            Row(
              children: [
                PersistentShoppingCart().showTotalAmountWidget(
                  cartTotalAmountWidgetBuilder: (double totalAmount) {
                    return Text(
                      'Total: ${getFormatMoney(totalAmount)}',
                      style: context.bodyMedium,
                    ).paddingOnly(right: 12.w);
                  },
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButtonWidget(
                title: 'Realizar pedido',
                onPressed: () => _checkout(),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 12.w),
      ],
    );
  }
}
