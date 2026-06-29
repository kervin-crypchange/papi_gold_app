import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (int itemCount) {
              return IconButton(
                icon: Badge.count(
                  count: itemCount,
                  child: Icon(Icons.shopping_cart_outlined),
                ),
               onPressed: () => context.goNamed(Routes.cart),
              );
            },
          ),
          IconButton(
            onPressed: () => debugPrint('press'),
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text('PapiGold Home Page', style: context.titleMedium),
        ),
      ),
    );
  }
}
