import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/enums/app_sockets_enum.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/utils/directions_sheet.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/services/socket_service.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with MessengerMixin, LoggerMixin {
  List<ConnectivityResult> _connectionStatus = [
    ConnectivityResult.wifi,
    ConnectivityResult.mobile,
  ];
  final Connectivity _connectivity = Connectivity();

  bool get _isConnected =>
      _connectionStatus.contains(ConnectivityResult.wifi) ||
      _connectionStatus.contains(ConnectivityResult.mobile);

  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  int _currentIndex = 0;
  late String token;
  SocketService socketService = SocketService();
  DateTime? _lastPressedTime;

  final List<Widget> pages = [
    HomePage(),
    ProductsPage(),
    OrdersPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    initConnectivity();
    initSocket();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      messenger.showSnackBar(
        'Couldn\'t check connectivity status',
        color: AppColors.error,
        icon: Icons.error_outline_outlined,
      );
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (_connectionStatus.contains(result.first)) return;

    setState(() {
      _connectionStatus = result;
    });

    if (_connectionStatus.contains(ConnectivityResult.none)) {
      messenger.showSnackBar(
        'No tienes conexión',
        icon: Icons.wifi_off,
        color: AppColors.error,
        seconds: 3,
      );
    }

    if (_isConnected) {
      messenger.showSnackBar(
        'La conexión ha vuelto',
        icon: Icons.wifi,
        color: AppColors.success,
        seconds: 3,
      );
    }
  }

  Future<void> initSocket() async {
    await socketService.init();
    
    await socketService.listenToPrivateChannel(
      AppSocketsEnum.notification.channel,
      AppSocketsEnum.notification.event,
      (data) {
        log('--- $data');
        messenger.showSnackBar(data, color: AppColors.secondary);
      },
    );

    await socketService.listenToPublicChannel(
      AppSocketsEnum.product.channel,
      AppSocketsEnum.product.event,
      (data) {
        log('--- $data');
        messenger.showSnackBar(data, color: AppColors.secondary);
      },
    );
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
        title: showSelectedDirection(context),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (int itemCount) {
              return IconButton(
                icon: (itemCount > 0)
                    ? Badge.count(
                        count: itemCount,
                        child: Icon(Icons.shopping_cart_outlined, size: 18.w),
                      )
                    : Icon(Icons.shopping_cart_outlined, size: 18.w),
                onPressed: () => context.goNamed(Routes.cart),
              );
            },
          ),
          IconButton(
            onPressed: () => context.goNamed(Routes.notifications),
            icon: Icon(Icons.notifications_none_outlined, size: 18.w),
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          final now = DateTime.now();
          const maxDuration = Duration(seconds: 2);

          if (_lastPressedTime == null ||
              now.difference(_lastPressedTime!) > maxDuration) {
            _lastPressedTime = now;
            messenger.showSnackBar(
              'Presione de nuevo para salir',
              color: AppColors.greyLigth,
            );
          } else {
            await SystemNavigator.pop();
          }
        },
        child: Stack(
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
      ),
    );
  }
}
