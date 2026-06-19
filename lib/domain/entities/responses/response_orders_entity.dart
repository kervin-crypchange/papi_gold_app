import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

class ResponseOrdersEntity extends Equatable{
  final List<OrderDetailEntity> data;
  final MetaEntity meta;
  final StatsEntity stats;

  const ResponseOrdersEntity({required this.data, required this.stats, required this.meta});
  @override
   List<Object?> get props => [data, meta, stats];

}