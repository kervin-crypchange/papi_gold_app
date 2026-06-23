import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ShippingEntity extends Equatable {
  final int id;
  final String tracking;
  final String address;
  final CourierEntity courier;
  final StatusEntity status;

  const ShippingEntity({
    required this.id,
    required this.courier,
    required this.address,
    required this.status,
    required this.tracking,
  });

  @override
  List<Object?> get props => [id, courier, address, status, tracking];
}

class CourierEntity extends Equatable {
  final int id;
  final String name;

  const CourierEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

