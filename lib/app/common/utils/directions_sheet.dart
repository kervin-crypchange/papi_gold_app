import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/directions/directions_cubit.dart';

Widget showSelectedDirection(BuildContext context) {
  return TextButton(
    onPressed: () => showDirectionsSheet(context),
    child: PersistentDirection().showSelectedDirection(
      directionBuilder: (context, direction) {
        return Row(
          children: [
            Expanded(
              child: Text(
                '${direction.address1} ${direction.address2}',
                style: context.bodySmall.copyWith(color: AppColors.white),
              ).overflowText(TextOverflow.ellipsis),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.white,),
          ],
        );
      },
    ),
  );
}

void showDirectionsSheet(BuildContext context) {
  final selectedDirection = PersistentDirection().selectedDirection();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 0.3.sh,
          maxHeight: 0.9.sh,
        ),
        child: IntrinsicHeight(
          child: PersistentDirection().showDirections(
            directionBuilder: (context, directions) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.h,
                children: [
                  Text(
                    'Elije tu dirección',
                    style: context.titleSmall.copyWith(color: AppColors.white),
                  ).paddingOnly(bottom: 6.h).medium,
                  ...directions.map((direction) {
                    return ListTile(
                      minTileHeight: 40,
                      isThreeLine: true,
                      selected: selectedDirection.id == direction.id,
                      title: Text(
                        '${direction.name} - ${direction.address1}',
                      ).overflowText(TextOverflow.ellipsis),
                      subtitle: Text(
                        '${direction.city['name']}, ${direction.state['name']}. ${direction.country['name']}',
                      ),
                      onTap: () {
                        PersistentDirection().addSelected(direction);
                        context.pop();
                      },
                    );
                  }),
                  ListTile(
                    minTileHeight: 40,
                    leading: Icon(Icons.add),
                    title: Text('Agregar dirección'),
                    subtitle: Text('Ingresa una nueva dirección de entrega'),
                    onTap: () {
                      if (directions.length < 3) {
                        context.read<DirectionsCubit>().direction = null;
                        context.pop();
                        context.goNamed(Routes.newAddress);
                      } else {
                        showOkAlertDialog(
                          context: context,
                          title: 'Ha ocurrido un error',
                          message:
                              'Solo puedes agregar un maximo de 3 dirección, si deseas agregar otra, elimina la que ya tienes.',
                        );
                      }
                    },
                  ),
                ],
              ).paddingOnly(bottom: 70.h);
            },
          ),
        ),
      );
    },
  );
}
