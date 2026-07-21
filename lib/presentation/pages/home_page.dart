import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Icon(Icons.location_city)
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
