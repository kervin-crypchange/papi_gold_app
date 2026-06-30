import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:papi_gold/app/core/extensions/index.dart' as globals;
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
    await Hive.openBox(BoxEnum.config.name);
    await PersistentShoppingCart().init();
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
  late final StreamSubscription<String> _localeSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _localeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: (context, child) {
      return MaterialApp.router(
          debugShowCheckedModeBanner: true,
          theme: appTheme(),
          routerConfig: router,
          scaffoldMessengerKey: globals.scaffoldMessengerKey,
        );
      },
    );
  }
}
