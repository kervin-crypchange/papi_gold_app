import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductInfoEntity extends Equatable {
  final int id;
  final String name;
  final List<ProductEntity> products;

  const ProductInfoEntity({
    required this.id,
    required this.name,
    required this.products,
  });
  @override
  List<Object?> get props => [id, name, products];
}
