import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/common/services/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/app_localizations.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';
import 'package:papi_gold/app/core/extensions/index.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(BoxEnum.config.name);
  await initializeDependencies();

  runApp(const BlocProviders());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthCubit>())],
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
  Locale? _locale;
  late final StreamSubscription<String> _localeSubscription;
  final List<Locale> _supportedLocales = const [Locale('en', 'US'), Locale('es', 'MX')];

  @override
  void initState() {
    super.initState();
    _localeSubscription = LocaleService.localeStream.listen((localeStr) {
      Locale newLocale;
      try {
        if (localeStr.contains('_')) {
          final parts = localeStr.split('_');
          newLocale = Locale(parts[0], parts.length > 1 ? parts[1] : '');
        } else if (localeStr.contains('-')) {
          final parts = localeStr.split('-');
          newLocale = Locale(parts[0], parts.length > 1 ? parts[1] : '');
        } else {
          newLocale = Locale(localeStr);
        }
      } catch (_) {
        newLocale = _supportedLocales.first;
      }

      final matched = _supportedLocales.firstWhere(
        (l) => l.languageCode == newLocale.languageCode,
        orElse: () => _supportedLocales.first,
      );

      if (mounted) {
        setState(() {
          _locale = matched;
        });
      }
    });
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
          locale: _locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en', 'US'), Locale('es', 'MX')],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: appTheme(),
          routerConfig: router,
          scaffoldMessengerKey: globals.scaffoldMessengerKey,
        );
      },
    );
  }
}
