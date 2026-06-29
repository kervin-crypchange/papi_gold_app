import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
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
      appBar: AppBar(title: Text('Mi carrito')),
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
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: Colors.black38,
                      leading: Image.network(item.productImages![0]),
                      title: Text(item.productName),
                      subtitle: Text(
                        getFormatMoney(item.totalPrice),
                        style: context.labelLarge,
                      ),
                    ).paddingOnly(bottom: 6.h);
                  },
                );
              },
        ),
      ).paddingSymmetric(horizontal: 12.w),
    );
  }
}
