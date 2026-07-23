import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
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
  bool isLoading = true;
  List<DirectionEntity> _directions = [];
  @override
  void initState() {
    super.initState();
    context.read<DirectionsCubit>().list();
  }

  void _showModalSheet(BuildContext context, DirectionEntity direction) async {
    final res = await showModalActionSheet(
      context: context,
      title: direction.name,
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

    if (res == 'delete') {
      final r = await showOkCancelAlertDialog(
        context: context,
        title: direction.name,
        message: '¿Esta seguro que desea eliminar esta dirección?',
      );
      if (r == OkCancelResult.ok) _delete(direction.id!);
    }
  }

  void _delete(int id) {
    showLoading(context);
    context.read<DirectionsCubit>().delete(id).then((either) {
      either.fold((l) => null, (r) {
        showLoading(context, false);
        messenger.showSnackBar(message: r);
        _directions.removeWhere((d) => d.id == id);
        setState(() {
          _directions = _directions;
        });
      });
    });
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
              _directions = state.response.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  directionCard(state.response.primaryDirection),
                  Expanded(child: _listViewUI(_directions)),
                ],
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

  ListView _listViewUI(List<DirectionEntity> directions) {
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(12.h),
      itemCount: directions.length,
      itemBuilder: (BuildContext context, int index) {
        final direction = directions[index];
        return directionCard(direction);
      },
    );
  }

  Widget directionCard(DirectionEntity d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Text(
          d.type == 'primary' ? 'Dirección principal' : d.name.capitalizeFirst,
          style: context.bodyMedium.copyWith(color: Colors.white54),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListTile(
            title: Text('${d.address1}, ${d.address2}. ${d.codeZip}.'),
            subtitle: Text('${d.city.name} ${d.state.name}. ${d.country.name}'),
            dense: true,
            trailing: (d.type != 'primary')
                ? InkWell(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.more_vert,
                      size: 18.r,
                      color: Colors.white38,
                    ).paddingAll(10.r),
                    onTap: () => _showModalSheet(context, d),
                  )
                : null,
            onLongPress: () => debugPrint('--- onLongPress ${d.id}'),
          ),
        ),
      ],
    );
  }
}
