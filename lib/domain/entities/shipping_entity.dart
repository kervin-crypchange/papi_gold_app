import 'package:equatable/equatable.dart';

class ShippingEntity extends Equatable {
  final int id;
  final String tracking;
  final CourierEntity courier;
  final StatusEntity status;

  const ShippingEntity({
    required this.id,
    required this.courier,
    required this.status,
    required this.tracking,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CourierEntity extends Equatable {
  final int id;
  final String name;

  const CourierEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class StatusEntity extends Equatable {
  final int id;
  final String name;

  const StatusEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
