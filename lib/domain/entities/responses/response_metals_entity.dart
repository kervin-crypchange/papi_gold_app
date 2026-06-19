import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseMetalsEntity extends Equatable {
  final List<MetalEntity> data;
  
  const ResponseMetalsEntity({required this.data});
  @override
  List<Object?> get props => [data];
}
