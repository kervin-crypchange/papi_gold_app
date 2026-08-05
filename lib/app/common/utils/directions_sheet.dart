  import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/direction/persistent_direction.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

void showDirectionsSheet(BuildContext context) {
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
                    dense: true,
                    isThreeLine: true,
                    title: Text(
                      direction.name,
                    ).overflowText(TextOverflow.ellipsis),
                    subtitle: Text(
                      '${direction.address1}, ${direction.address2}'
                      '${direction.city['name']}, ${direction.state['name']}. ${direction.country['name']}',
                    ),
                    onTap: () => log('--- onTap ${direction.name}'),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.white),
                itemCount: directions.length,
              ).paddingOnly(top: 12.h);
            },
          ),
        );
      },
    );
  }