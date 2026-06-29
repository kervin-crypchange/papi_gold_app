import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    ProductsPage(),
    OrdersPage(),
    CartPage(),
  ];

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
      'icon': Icons.shopping_cart_outlined,
      'iconSelected': Icons.shopping_cart_rounded,
      'label': 'Carrito',
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(child: pages[_currentIndex]),
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
