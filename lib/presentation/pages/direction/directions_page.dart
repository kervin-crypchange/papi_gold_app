import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/directions/directions_cubit.dart';

class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> with MessengerMixin {
  // late final List<DirectionEntity> directions;
  // late final DirectionEntity primaryDirection;
  // late final MetaEntity meta;

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    context.read<DirectionsCubit>().list();
  }

  void _showModalSheet(BuildContext context, DirectionEntity direction) async {
    final res = await showModalActionSheet(
      context: context,
      title: '${direction.address1}, ${direction.address2}',
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
    if (!context.mounted) return;

    if (res == 'edit') {
      context.read<DirectionsCubit>().direction = direction;
      context.goNamed(Routes.newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Direcciones')),
      body: SafeArea(
        child: BlocBuilder<DirectionsCubit, DirectionsState>(
          builder: (context, state) {
            if (state is DirectionsLoading) {
              return LoadingWidget();
            }
            if (state is DirectionsSuccess) {
              return ListView.separated(
                separatorBuilder: (context, index) => Gap(12.h),
                itemCount: state.response.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final direction = state.response.data[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ListTile(
                      title: Text(direction.name),
                      subtitle: Text(
                         '${direction.address1}, ${direction.address2}. ${direction.codeZip}, ${direction.state.name}',
                      ),
                      dense: true,
                      trailing: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(
                          Icons.more_vert,
                          size: 18.r,
                          color: Colors.white38,
                        ).paddingAll(10.r),
                        onTap: () => _showModalSheet(context, direction),
                      ),
                      onLongPress: () =>
                          debugPrint('--- onLongPress ${direction.id}'),
                    ),
                  );
                },
              ).paddingAll(8.r);
            }
            return Center(child: Text('Ha ocurrido un error'));
          },
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: 0.9.sw,
          child: FilledButtonWidget(
            title: 'Agregar dirección',
            onPressed: () {
              context.read<DirectionsCubit>().direction = null;
              context.goNamed(Routes.newAddress);
            },
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border(top: BorderSide.none),
      ),
    );
  }
}
