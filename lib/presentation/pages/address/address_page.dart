import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Direcciones')),
      body: SafeArea(
        child: Center(child: Text('Direcciones', style: context.labelLarge)),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: 0.9.sw,
          child: FilledButtonWidget(
            title: 'Agregar dirección',
            onPressed: () => context.goNamed(Routes.newAddress),
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border(top: BorderSide.none),
      ),
    );
  }
}
