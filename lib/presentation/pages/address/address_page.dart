import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool _isDense = false;

  final List<AddressEntity> address = [
    AddressEntity(
      id: 1,
      country: AddressLocationEntity(id: 1, name: 'Venezuela'),
      state: AddressLocationEntity(id: 1, name: 'Vargas'),
      city: AddressLocationEntity(id: 1, name: 'Macuto'),
      address1: 'Av. Intercomunal Macuto',
      address2: 'Sector El Cojo',
      zipCode: 1160,
      isMain: true,
    ),
    AddressEntity(
      id: 2,
      country: AddressLocationEntity(id: 1, name: 'Venezuela'),
      state: AddressLocationEntity(id: 2, name: 'Distrito Capital'),
      city: AddressLocationEntity(id: 1, name: 'Caracas'),
      address1: 'La Pastora',
      address2: '',
      zipCode: 1160,
      isMain: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direcciones'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isDense = !_isDense;
              });
            },
            icon: Icon(_isDense ? Icons.open_in_full : Icons.close_fullscreen),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => Gap(12.h),
          itemCount: address.length,
          itemBuilder: (BuildContext context, int index) {
            final add = address[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                title: Text(
                  '${add.address1}, ${add.address2}. ${add.zipCode}',
                ),
                subtitle: Text('${add.city.name}, ${add.state.name}. ${add.country.name}'),
                dense: _isDense,
                trailing: InkWell(
                  onTap: () => debugPrint('--- tapped'),
                  child: Icon(Icons.edit, size: 18.r),
                ),
              ),
            );
          },
        ).paddingAll(8.r),
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
