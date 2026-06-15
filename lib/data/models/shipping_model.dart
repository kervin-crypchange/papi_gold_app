import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ShippingModel extends ShippingEntity {
  const ShippingModel({
    required super.id,
    required super.courier,
    required super.status,
    required super.tracking,
  });

  /// Converts a JSON map to a [ShippingModel].
  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
      id: safeInt(json['id']),
      courier: CourierModel.fromJson(json['courier']),
      status: StatusModel.fromJson(json['status']),
      tracking: safeString(json['tracking_number']),
    );
  }

  /// Converts a [ShippingModel] to a [ShippingEntity].
  factory ShippingModel.fromEntity(ShippingEntity e) {
    return ShippingModel(
      id: e.id,
      courier: e.courier,
      status: e.status,
      tracking: e.tracking,
    );
  }

  /// Converts a [ShippingModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courier': CourierModel.fromEntity(courier).toJson(),
      'status': StatusModel.fromEntity(status).toJson(),
      'tracking_number': tracking,
    };
  }
}

class CourierModel extends CourierEntity {
  const CourierModel({required super.id, required super.name});

  /// Converts a JSON map to a [CourierModel].
  factory CourierModel.fromJson(Map<String, dynamic> json) {
    return CourierModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );
  }

  /// Converts a [CourierModel] to a [CourierEntity].
  factory CourierModel.fromEntity(CourierEntity e) {
    return CourierModel(id: e.id, name: e.name);
  }

  /// Converts a [CourierModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class StatusModel extends StatusEntity {
  const StatusModel({required super.id, required super.name});

  /// Converts a JSON map to a [StatusModel].
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );
  }

  /// Converts a [StatusEntity] to a [StatusModel].
  factory StatusModel.fromEntity(StatusEntity e) {
    return StatusModel(id: e.id, name: e.name);
  }

  /// Converts a [StatusModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'key': id, 'name': name};
  }
}
