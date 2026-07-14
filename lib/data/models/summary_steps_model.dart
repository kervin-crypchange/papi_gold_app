import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/summary_steps_entity.dart';

class SummaryStepsModel extends SummaryStepsEntity {
  const SummaryStepsModel({
    required super.id,
    required super.label,
    required super.status,
  });

  factory SummaryStepsModel.fromJson(Map<String, dynamic> json) {
    return SummaryStepsModel(
      id: safeString(json['id']),
      label: safeString(json['label']),
      status: safeString(json['status']),
    );
  }
}
