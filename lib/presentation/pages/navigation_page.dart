import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/widget.dart';
import 'package:papi_gold/presentation/pages/index.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  final List<Widget> _destinations = [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Ordenes'),
    NavigationDestination(
      icon: Icon(Icons.person_pin_rounded),
      label: 'Perfil',
    ),
  ];

  void _onSelectedPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [HomePage(), OrdersPage(), ProfilePage()][currentPageIndex].paddingAll(12.r),
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: currentPageIndex,
        onDestinationSelected: _onSelectedPage,
      ),
    );
  }
}
