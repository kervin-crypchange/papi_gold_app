import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/text_style.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/prices/prices_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MetalsPriceWidget extends StatefulWidget {
  const MetalsPriceWidget({super.key});

  @override
  State<MetalsPriceWidget> createState() => _MetalsPriceWidgetState();
}

class _MetalsPriceWidgetState extends State<MetalsPriceWidget> {
  late final List<MetalEntity> metals;
  final Map<String, List<dynamic>> symbol = {
    'Oro': ['XAU', Colors.blue],
    'Plata': ['XAG', Colors.red],
    'Platino': ['XPT', Colors.green],
    'Paladio': ['XPD', Colors.cyan],
  };

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
          return Expanded(
            child: Skeletonizer(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Metal Spot Price', style: context.bodySmall),
                          Gap(6.h),
                          Text('100.00', style: context.titleSmall).medium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text('XAU', style: context.bodyXSmall)],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
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
                childAspectRatio: 1.65,
              ),
              itemBuilder: (context, index) {
                final MetalEntity metal = state.metals[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${metal.name} Spot Price',
                          style: context.bodySmall,
                        ),
                        Gap(6.h),
                        Text(
                          getFormatMoney(metal.price),
                          style: context.titleMedium,
                        ).medium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${symbol[metal.name]![0]}',
                              style: context.bodyXSmall.copyWith(
                                color: symbol[metal.name]![1],
                              ),
                            ),
                          ],
                        ),
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
