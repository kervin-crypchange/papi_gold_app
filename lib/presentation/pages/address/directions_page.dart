import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
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

  void _showModalSheet(BuildContext context, AddressEntity address) async {
    final res = await showModalActionSheet(
      context: context,
      title: '${address.address1}, ${address.address2}',
      actions: [
        SheetAction(label: 'Editar', icon: Icons.edit_outlined, key: 'edit'),
        SheetAction(
          label: 'Eliminar',
          icon: Icons.delete_outline,
          isDestructiveAction: true,
          key: 'delete',
        ),
      ],
    );
    if(!context.mounted) return;

    if (res == 'edit') {
      context.goNamed(Routes.newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Direcciones')),
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
                title: Text('${add.address1}, ${add.address2}. ${add.zipCode}'),
                subtitle: Text(
                  '${add.city.name}, ${add.state.name}. ${add.country.name}',
                ),
                dense: true,
                trailing: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(
                    Icons.more_vert,
                    size: 18.r,
                    color: Colors.white38,
                  ).paddingAll(10.r),
                  onTap: () => _showModalSheet(context, add),
                ),
                onLongPress: () => debugPrint('--- onLongPress ${add.id}'),
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
