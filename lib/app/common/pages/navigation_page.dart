import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with MessengerMixin {

  int _currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    ProductsPage(),
    OrdersPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // context.read<AppSocketCubit>().connect(AppSocketsEnum.notification);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<Map<String, dynamic>> navItems = [
    {
      'icon': Icons.home_outlined,
      'iconSelected': Icons.home_rounded,
      'label': 'Home',
    },
    {
      'icon': Icons.inventory_2_outlined,
      'iconSelected': Icons.inventory_2_rounded,
      'label': 'Productos',
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'iconSelected': Icons.shopping_bag_rounded,
      'label': 'Ordenes',
    },
    {
      'icon': Icons.settings_outlined,
      'iconSelected': Icons.settings_rounded,
      'label': 'Setting',
    },
  ];

  void _onSelectedPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (int itemCount) {
              return IconButton(
                icon: (itemCount > 0)
                    ? Badge.count(
                        count: itemCount,
                        child: Icon(Icons.shopping_cart_outlined),
                      )
                    : Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.goNamed(Routes.cart),
              );
            },
          ),
          IconButton(
            onPressed: () => context.goNamed(Routes.notifications),
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(bottom: false, child: pages[_currentIndex]),
          CustomNavBar(
            currentIndex: _currentIndex,
            navItems: navItems,
            onTap: _onSelectedPage,
          ),
        ],
      ),
    );
  }
}
