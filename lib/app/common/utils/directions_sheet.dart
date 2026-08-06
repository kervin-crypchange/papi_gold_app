import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';

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
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 200.0, // Your desired minimum height
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: PersistentDirection().showDirections(
          directionBuilder: (context, directions) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final direction = directions[index];
                return ListTile(
                  dense: false,
                  isThreeLine: true,
                  selected: selectedDirection.id == direction.id,
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
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

