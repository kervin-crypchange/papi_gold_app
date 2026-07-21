import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';

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
      body: Scaffold(
        body: Column(
          children: [
            Container(
              height: 0.55.sh,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.blackLigth),
            ),
            Center(child: Text('Confirma tu dirección', style: context.titleLarge,),).paddingOnly(top: 12.h)
          ],
        ),
      ),

    );
  }
}
