import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:papi_gold/presentation/widgets/index.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with MessengerMixin {
  final ScrollController _scrollController = ScrollController();
  List<ProductInfoModel> products = [];
  MetaEntity? meta;
  bool isLoading = true;
  bool isGridView = true;
  final Duration duration =  Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    _loadData(1);
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadData(int page) async {
    context.read<ProductCubit>().list(page).then((either) {
      either.fold(
        (failure) => setState(() => products = []),
        (response) => setState(() {
          meta = response.meta;
          products.addAll(response.data);
          isLoading = false;
        }),
      );
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (meta!.currentPage < meta!.lastPage) {
        _loadData(meta!.currentPage + 1);
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
    return isLoading
        ? LoadingAnimatedWidget()
        : ListView.builder(
            padding: EdgeInsets.only(bottom: navBarHeight(context)),
            scrollCacheExtent: ScrollCacheExtent.viewport(1.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final data = products[index];
              return Column(
                spacing: 6.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                    icon: AnimatedSwitcher(
                      duration: duration,
                      child: isGridView
                          ? Icon(Icons.view_list)
                          : Icon(Icons.grid_view),
                    ),
                  ),
                  Text(
                    data.name,
                    style: context.bodyLarge.copyWith(
                      color: context.accentColor,
                    ),
                  ).paddingOnly(top: 6.h, left: 12.w),
                  AnimatedSwitcher(
                    duration: duration,
                    child: isGridView
                        ? ProductGridView(data: data)
                        : ProductsListView(data: data),
                  ),
                ],
              );
            },
          );
  }
}
