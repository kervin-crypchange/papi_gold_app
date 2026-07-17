import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis direcciones')),
      body: SafeArea(
        child: Center(child: Text('Address Page', style: context.labelLarge)),
      ),
    );
  }
}
