
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => debugPrint('press'),
            icon: Icon(Icons.person_2_outlined),
          ),
          IconButton(
            onPressed: () => debugPrint('press'),
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text('PapiGold Home Page', style: context.titleMedium),
        ),
      ),
    );
  }
}
