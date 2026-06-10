import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/injection_container.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: appTheme(),
          home: Scaffold(body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PapiGold!', style: context.bodyMedium,),
              // Image.asset('assets/icons/icon512_rounded.png', )
            ],
          ))),
        );
      },
    );
  }
}
