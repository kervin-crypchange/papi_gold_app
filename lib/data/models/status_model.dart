import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class StatusModel extends StatusEntity {
  const StatusModel({required super.name, super.color});

  /// Converts a JSON map to a [StatusModel].
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      name: safeString(json['name']),
      color: safeString(json['color']),
    );
  }
}