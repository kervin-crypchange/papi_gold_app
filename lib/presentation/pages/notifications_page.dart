import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationEntity> nots = [];
  MetaEntity? meta;
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData(1);
    _scrollController.addListener(_onScroll);
  }

  Future<void> loadData(int page) async {
    context.read<NotificationsCubit>().list(page).then((either) {
      either.fold(
        (failure) => setState(() => nots = []),
        (response) => setState(() {
          meta = response.meta;
          nots.addAll(response.data);
          isLoading = false;
        }),
      );
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (meta!.currentPage < meta!.lastPage) {
        loadData(meta!.currentPage + 1);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? LoadingAnimatedWidget()
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                scrollCacheExtent: ScrollCacheExtent.viewport(1.0),
                itemCount: nots.length,
                itemBuilder: (context, index) {
                  final not = nots[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/papi-gold-512x512.png',
                        height: 28.h,
                      ),
                      title: Text(not.data.title),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
