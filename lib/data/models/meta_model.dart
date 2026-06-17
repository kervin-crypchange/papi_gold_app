import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class MetaModel extends MetaEntity {
  const MetaModel({
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
  });

  /// Converts a JSON map to a [MetaModel].
  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: safeInt(json['current_page']),
      lastPage: safeInt(json['last_page']),
      perPage: safeInt(json['per_page']),
      total: safeInt(json['total']),
    );
  }

  /// Converts a [MetaEntity] to a [MetaModel].
  factory MetaModel.fromEntity(MetaEntity e) {
    return MetaModel(
      currentPage: e.currentPage,
      lastPage: e.lastPage,
      perPage: e.perPage,
      total: e.total,
    );
  }

  /// Converts a [MetaModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
