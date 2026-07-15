import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with MessengerMixin {
  // late WebSocketChannel _channel;

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
    debugPrint('--- initState NavigationPage');
    context.read<AppSocketCubit>().connect(AppSocketsEnum.notification);
    // _iniSocket();
  }

  // Future<void> _iniSocket() async {
  //   debugPrint('--- InitSocket');

  //   final String token = sl<AuthLocalData>().getSavedToken();
  //   final wsUrl = Uri.parse('ws://192.168.100.162:443');
  //   _channel = IOWebSocketChannel.connect(
  //     wsUrl,
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'x-api-key': 'cYaS7nA1IHUzuZQ42AbjPYzsiygFmegUiARPPv6t',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   await _channel.ready;

  //   _channel.stream.listen(
  //     (event) {
  //       debugPrint('--- New event received: $event');
  //     },
  //     onError: (error) {
  //       debugPrint('--- WebSocket error: $error');
  //     },
  //     onDone: () {
  //       debugPrint('--- WebSocket connection closed.');
  //     },
  //     cancelOnError: true,
  //   );
  // }

  @override
  void dispose() {
    // _channel.sink.close();
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
      body: BlocListener<AppSocketCubit, AppSocketState>(
        listener: (context, state) {
          if (state is AppSocketConnected) {
            messenger.showSnackBar(
              message: 'Conexion exitosa',
              color: AppColors.success,
            );
          }
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              pages[_currentIndex],
              CustomNavBar(
                currentIndex: _currentIndex,
                navItems: navItems,
                onTap: _onSelectedPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
