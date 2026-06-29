import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Cart Page', style: context.titleMedium),
        ),
      ),
    );
  }
}