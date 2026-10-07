import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/uses_cases/notifications_use_case.dart';
import 'package:papi_gold/injection_container.dart';
import 'package:papi_gold/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:papi_gold/presentation/widgets/unread_count_widget.dart';

class _FakeNotificationCountUseCase extends NotificationCountUseCase {
  _FakeNotificationCountUseCase(this.responses);

  final List<Either<Failure, int>> responses;
  int callCount = 0;

  @override
  Future<Either<Failure, int>> call({void param}) async {
    return responses[callCount++];
  }
}

void main() {
  late _FakeNotificationCountUseCase countUseCase;

  setUp(() {
    countUseCase = _FakeNotificationCountUseCase([
      const Right(2),
      const Right(3),
    ]);
    sl.registerSingleton<NotificationCountUseCase>(countUseCase);
  });

  tearDown(() async {
    await sl.unregister<NotificationCountUseCase>();
  });

  test('emits each refreshed unread count', () async {
    final cubit = NotificationsCubit();
    final states = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<NotificationsLoading>(),
        isA<NotificationsUnreadSuccess>().having(
          (state) => state.count,
          'count',
          2,
        ),
        isA<NotificationsLoading>(),
        isA<NotificationsUnreadSuccess>().having(
          (state) => state.count,
          'count',
          3,
        ),
      ]),
    );

    await cubit.count();
    await cubit.count();
    await states;

    expect(countUseCase.callCount, 2);
    await cubit.close();
  });

  test('emits the unread-count failure state when the request fails', () async {
    await sl.unregister<NotificationCountUseCase>();
    countUseCase = _FakeNotificationCountUseCase([
      const Left(UnknownFailure()),
    ]);
    sl.registerSingleton<NotificationCountUseCase>(countUseCase);

    final cubit = NotificationsCubit();
    final states = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<NotificationsLoading>(),
        isA<NotificationsUnreadFailure>(),
      ]),
    );

    await cubit.count();
    await states;

    expect(countUseCase.callCount, 1);
    await cubit.close();
  });

  testWidgets('loads and refreshes the unread badge count', (tester) async {
    final cubit = NotificationsCubit();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: [
                BlocProvider.value(
                  value: cubit,
                  child: const UnreadCountWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget);
    expect(countUseCase.callCount, 1);

    await cubit.count();
    await tester.pumpAndSettle();

    expect(find.text('3'), findsOneWidget);
    expect(countUseCase.callCount, 2);

    await cubit.close();
  });
}
