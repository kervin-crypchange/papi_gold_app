import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('PapiGold Home Page', style: context.titleMedium),
            ElevatedButton(
              onPressed: () => context.goNamed('login'),
              child: Text('Go to login'),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed('register'),
              child: Text('Go to register'),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed('recovery'),
              child: Text('Go to recovery password'),
            ),
          ],
        ),
      ),
    );
  }
}
