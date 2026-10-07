import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/common/services/location_service.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/config/app_config.dart';
import 'package:papi_gold/app/core/services/index.dart';
import 'package:papi_gold/app/core/store/client/persistent_client_data.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:papi_gold/app/core/extensions/index.dart' as globals;
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

String publishableKey = const String.fromEnvironment(
  'STRIPE_PUBLISHABLE_KEY',
  defaultValue: 'pk_test_51T3zYL8jtYx1E1JT3qN550tkyWo3JYLrHcGGLGVAadTtGUA62FTusAQHoceMJZI8iJm0Mi0mvmpJXEk9auleG8ax008dKcvIoV',
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize(
    environment: const String.fromEnvironment(
      'APP_ENV',
      defaultValue: AppEnvironment.dev,
    ),
  );
  debugPrintRebuildDirtyWidgets = true;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  try {
    await Hive.initFlutter();
    Stripe.publishableKey = publishableKey;

    await Hive.openBox(BoxEnum.config.name);
    await AppThemes.loadThemeMode();
    SystemChrome.setSystemUIOverlayStyle(
      AppThemes.systemUiOverlayStyle(AppThemes.themeModeNotifier.value),
    );
    await LocationService().init();
    await PersistentShoppingCart().init();
    await PersistentClientData().init();
    await PersistentDirection().init();
    await initializeDependencies();
    runApp(const BlocProviders());
  } catch (e, st) {
    // Log and show a minimal error app so the user sees a friendly message
    debugPrint('App initialization failed: $e');
    debugPrint(st.toString());
    runApp(ErrorApp(error: e.toString()));
  }
}

class ErrorApp extends StatelessWidget {
  final String error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Inicialización fallida')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'La aplicación no pudo inicializarse:\n\n$error',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<OrdersCubit>()),
        BlocProvider(create: (_) => sl<ProductCubit>()),
        BlocProvider(create: (_) => sl<CheckoutCubit>()),
        BlocProvider(create: (_) => sl<PaymentCubit>()),
        BlocProvider(create: (_) => sl<LocationCubit>()),
        BlocProvider(create: (_) => sl<TrackingCubit>()),
        BlocProvider(create: (_) => sl<AppSocketCubit>()),
        BlocProvider(create: (_) => sl<DirectionsCubit>()),
        BlocProvider(create: (_) => sl<PricesCubit>()),
        BlocProvider(create: (_) => sl<NotificationsCubit>()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Locale? _locale;
  // late final StreamSubscription<String> _localeSubscription;

  @override
  void initState() {
    super.initState();
    AppThemes.themeModeNotifier.addListener(_updateSystemUiStyle);
    _updateSystemUiStyle();
    PermissionService().requestMultiplePermissions([
      Permission.camera,
      Permission.photos,
      Permission.location,
      Permission.notification,
    ]);
    // fullScreenConfig();
  }

  void _updateSystemUiStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      AppThemes.systemUiOverlayStyle(AppThemes.themeModeNotifier.value),
    );
  }

  @override
  void dispose() {
    AppThemes.themeModeNotifier.removeListener(_updateSystemUiStyle);
    // _localeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: AppThemes.themeModeNotifier,
          builder: (context, currentMode, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: true,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: currentMode,
              routerConfig: router,
              scaffoldMessengerKey: globals.scaffoldMessengerKey,
            );
          },
        );
      },
    );
  }
}