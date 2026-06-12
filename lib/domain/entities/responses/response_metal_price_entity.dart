import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseMetalPriceEntity extends Equatable {
  final bool success;
  final List<MetalEntity> data;

  const ResponseMetalPriceEntity({required this.success, required this.data});

  @override
  List<Object?> get props => [success, data];
}
