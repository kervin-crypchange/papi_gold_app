import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ShippingModel extends ShippingEntity {
  const ShippingModel({
    required super.id,
    required super.courier,
    required super.status,
    required super.tracking,
    required super.address,
  });

  /// Converts a JSON map to a [ShippingModel].
  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
      id: safeInt(json['id']),
      courier: CourierModel.fromJson(json['courier']),
      status: StatusModel.fromJson(json['status']),
      tracking: safeString(json['tracking_number']),
      address: safeString(json['address']),
    );
  }
}

class CourierModel extends CourierEntity {
  const CourierModel({required super.id, required super.name});

  /// Converts a JSON map to a [CourierModel].
  factory CourierModel.fromJson(Map<String, dynamic> json) {
    return CourierModel(
      id: safeInt(json['id']),
      name: safeString(json['name']),
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


