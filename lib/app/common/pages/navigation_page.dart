import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [HomePage(), ProductsPage(), OrdersPage(), CartPage(), ProfilePage()];

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
          CustomNavBar(currentIndex: _currentIndex, onTap: _onSelectedPage),
        ],
      ),
    );
  }
}
