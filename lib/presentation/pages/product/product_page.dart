import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class ProductPage extends StatelessWidget {
  final String id;
  const ProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().detail(safeInt(id));
     return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text('Product Page $id', style: context.titleMedium),
        ),
      ),
    );
  }
}