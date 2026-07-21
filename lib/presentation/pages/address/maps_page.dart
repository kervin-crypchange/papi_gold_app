import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar dirección'),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.newAddress),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Scaffold(body: Center(child: Text('Map'))),
    );
  }
}
