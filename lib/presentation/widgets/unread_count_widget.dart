import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class UnreadCountWidget extends StatefulWidget {
  const UnreadCountWidget({super.key});

  @override
  State<UnreadCountWidget> createState() => _UnreadCountWidgetState();
}

class _UnreadCountWidgetState extends State<UnreadCountWidget> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().count();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsUnreadSuccess) {
          _count = state.count;
        }
        if (state is NotificationsUnreadFailure) {
          _count = 0;
        }
        if (state is NotificationsLoading) {
          _count = 0;
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.goNamed(Routes.notifications),
          icon: _count > 0
              ? Badge.count(
                  count: _count,
                  child: Icon(Icons.notifications_active_outlined, size: 18.w),
                )
              : Icon(Icons.notifications_none_outlined, size: 18.w),
        );
      },
    );
  }
}
