import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ApiResponseEntity<T> extends Equatable {
  final List<T> data;
  final MetaEntity? meta;

  const ApiResponseEntity({required this.data, this.meta});
  @override
  List<Object?> get props => [data, meta];
}
