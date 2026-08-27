import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/prices/prices_cubit.dart';

class MetalsPriceWidget extends StatefulWidget {
  const MetalsPriceWidget({super.key});

  @override
  State<MetalsPriceWidget> createState() => _MetalsPriceWidgetState();
}

class _MetalsPriceWidgetState extends State<MetalsPriceWidget> {
  late final List<MetalEntity> metals;

  @override
  void initState() {
    super.initState();
    context.read<PricesCubit>().metals();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricesCubit, PricesState>(
      builder: (context, state) {
        if (state is PricesLoading) {
          return LoadingWidget();
        }
        if (state is PricesFailure) {
          return Text('Ha ocurrido un error');
        }
        if (state is PricesSuccess) {
          return Expanded(
            child: GridView.builder(
              itemCount: state.metals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final MetalEntity metal = state.metals[index];
                return Card(child: Text(metal.name));
              },
            ),
          );
        }
        return Text('No se pudo cargar los datos');
      },
    );
  }
}
