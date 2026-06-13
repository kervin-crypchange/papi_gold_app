import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductResponseEntity extends Equatable {
  final List<DataEntity> data;
  final MetaEntity meta;

  const ProductResponseEntity({required this.data, required this.meta});
  
  @override
  List<Object?> get props => [data, meta];
}

class DataEntity extends Equatable {
  final int id;
  final String name;
  final List<ProductEntity> products;

  const DataEntity({
    required this.id,
    required this.name,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, products];
}
