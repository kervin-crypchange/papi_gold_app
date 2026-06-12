import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/common/services/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
// import 'package:papi_gold/app/core/app_localizations.dart';
import 'package:papi_gold/app/core/router/router.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:papi_gold/app/core/extensions/index.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(BoxEnum.config.name);
  await initializeDependencies();

  runApp(const MainApp());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => sl<AuthenticatedCubit>()..appStarted()),
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
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
    LocaleService.localeStream.listen((locale) => setLocale(Locale(locale)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: true,
          // locale: _locale,
          // localizationsDelegates: [
          //   AppLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: [Locale('en', 'US'), Locale('es', 'MX')],
          // localeResolutionCallback: (deviceLocale, supportedLocales) {
          //   for (var locale in supportedLocales) {
          //     if (deviceLocale != null &&
          //         deviceLocale.languageCode == locale.languageCode) {
          //       return deviceLocale;
          //     }
          //   }
          //   return supportedLocales.first;
          // },
          theme: appTheme(),
          routerConfig: router,
          scaffoldMessengerKey: globals.scaffoldMessengerKey,
        );
      },
    );
  }
}
