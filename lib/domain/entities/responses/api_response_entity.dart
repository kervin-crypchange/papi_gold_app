import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ApiResponseEntity<T> extends Equatable {
  final List<T> data;
  final MetaEntity? meta;
  final StatsEntity? stats;

  const ApiResponseEntity({required this.data, this.meta, this.stats});
  @override
  List<Object?> get props => [data, meta, stats];
}
