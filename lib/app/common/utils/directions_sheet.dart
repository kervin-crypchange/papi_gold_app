import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

Widget showSelectedDirection(BuildContext context) {
  return Expanded(
    child: TextButton(
      onPressed: () => showDirectionsSheet(context),
      child: PersistentDirection().showSelectedDirection(
        directionBuilder: (context, direction) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  '${direction.address1} ${direction.address2}',
                ).overflowText(TextOverflow.ellipsis),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          );
        },
      ),
    ),
  );
}

void showDirectionsSheet(BuildContext context) {
  final selectedDirection = PersistentDirection().selectedDirection();
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        width: double.infinity,
        height: 0.5.sh,
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: PersistentDirection().showDirections(
          directionBuilder: (context, directions) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final direction = directions[index];
                return ListTile(
                  dense: false,
                  isThreeLine: true,
                  trailing: (selectedDirection.id == direction.id)
                      ? Icon(Icons.check_rounded)
                      : null,
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
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: directions.length,
            ).paddingOnly(top: 12.h);
          },
        ),
      );
    },
  );
}
