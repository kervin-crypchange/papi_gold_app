import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseDirectionsEntity extends Equatable {
  final List<DirectionEntity> data;
  final DirectionEntity primaryDirection;
  final MetaEntity meta;
  
  const ResponseDirectionsEntity({
    required this.data,
    required this.primaryDirection,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, primaryDirection, meta];
}
