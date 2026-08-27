import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/text_style.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
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
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 16 / 9,
              ),
              itemBuilder: (context, index) {
                final MetalEntity metal = state.metals[index];
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${metal.name} Spot Price',
                          style: context.bodySmall,
                        ),
                        Gap(8.h),
                        Text(
                          getFormatMoney(metal.price),
                          style: context.titleSmall,
                        ).medium,
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Text('No se pudo cargar los datos');
      },
    );
  }
}
