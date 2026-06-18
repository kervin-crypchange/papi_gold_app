import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/presentation/pages/home_page.dart';
import 'package:papi_gold/presentation/pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  final List<Widget> _destinations = [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.person_pin_rounded), label: 'Perfil'),
  ];

  final List<Widget> _pages = [HomePage(), ProfilePage()];

  void _onSelectedPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: currentPageIndex,
        onDestinationSelected: _onSelectedPage,
      ),
    );
  }
}
