import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/order_detail_entity.dart';

class ResponseOrdersEntity extends Equatable{
  final List<OrderDetailEntity> data;

  const ResponseOrdersEntity({required this.data});
  @override
  List<Object?> get props => throw [data];
}