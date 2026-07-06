import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/checkout/checkout_cubit.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
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
  late PersistentClientDataModel client;
  CheckOutEntity? checkout;
  bool isLoading = false;

  void _checkout() {
    if (_cartItems.isEmpty) {
      messenger.showSnackBar(
        message: 'No hay items en el carrito',
        color: AppColors.error,
      );
      return;
    }

    checkout = CheckOutEntity(
      client: ClientEntity(
        name: client.name,
        lastName: client.lastName,
        email: client.email,
        phone: client.phone,
        address1: client.address1,
        address2: client.address2,
        city: client.cityId,
        country: client.countryId,
        state: client.stateId,
        codeZip: client.codeZip,
        receiveAdvertise: client.receiveAdvertise,
      ),
      cart: _cartItems
          .map(
            (item) => CartItemEntity(
              id: safeInt(item.productId),
              quantity: item.quantity,
              price: item.unitPrice,
              format: 1,
            ),
          )
          .toList(),
      confirmExistingClient: true,
    );
    setState(() {
      isLoading = true;
    });
    context.read<CheckOutCubit>().checkout(checkout!).then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (res) => setState(() {
          isLoading = false;
          _makePayment(res.clientSecret);
        })
      );
    });
  }

  void _makePayment(String clientSecret) async {
    await stripePayment(context, clientSecret);
    PersistentShoppingCart().clearCart();
  }

  @override
  void initState() {
    super.initState();
    client = PersistentClientData().getClientData();
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
        child: isLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : PersistentShoppingCart().showCartItems(
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
