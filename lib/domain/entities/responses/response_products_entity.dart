import 'package:equatable/equatable.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseProductsEntity extends Equatable {
  final List<ProductInfoModel> data;
  final MetaEntity meta;

  const ResponseProductsEntity({required this.data, required this.meta});
  
  @override
  List<Object?> get props => [data, meta];
}
