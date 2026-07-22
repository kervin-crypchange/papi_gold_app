import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';

class ResponseDirectionsEntity extends Equatable {
  final List<DirectionEntity> data;
  final DirectionEntity primaryDirection;
  final MetaData meta;
  
  const ResponseDirectionsEntity({
    required this.data,
    required this.primaryDirection,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, primaryDirection, meta];
}
