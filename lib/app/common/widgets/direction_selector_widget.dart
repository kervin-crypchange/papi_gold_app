import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';
import 'package:papi_gold/presentation/cubits/directions/directions_cubit.dart';

class DirectionSelectorWidget extends StatefulWidget {
  const DirectionSelectorWidget({super.key});

  @override
  State<DirectionSelectorWidget> createState() =>
      _DirectionSelectorWidgetState();
}

class _DirectionSelectorWidgetState extends State<DirectionSelectorWidget> {
  @override
  void initState() {
    super.initState();
    context.read<DirectionsCubit>().list();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectionsCubit, DirectionsState>(
      builder: (context, state) {
        if (state is DirectionsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DirectionsFailure) {
          return Text(state.message, style: context.labelXSmall);
        } else if (state is DirectionsSuccess) {
          final directions = [state.response.primaryDirection, ...state.response.data];
          if (directions.isEmpty) {
            return Text('No hay direcciones', style: context.labelXSmall);
          }
          final selectedDirection =
              context.read<DirectionsCubit>().direction ?? directions.first;
          return DropdownButton<DirectionEntity>(
            underline: const SizedBox(), 
            isExpanded: true,
            isDense: true,
            value: selectedDirection,
            onChanged: (direction) {
              context.read<DirectionsCubit>().direction = direction;
            },
            items: directions.map((direction) {
              return DropdownMenuItem<DirectionEntity>(
                value: direction,
                child: Text(direction.address1, style: context.bodySmall),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
