import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/summary_steps_model.dart';
import 'package:papi_gold/data/models/tracking_history_model.dart';
import 'package:papi_gold/domain/entities/index.dart';

class TrackingModel extends TrackingEntity {
  const TrackingModel({
    required super.trackingNumber,
    required super.status,
    required super.summarySteps,
    required super.history,
    required super.addressShipping,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      trackingNumber: safeString(['trackingNumber']),
      addressShipping: safeString(['addressShipping']),
      status: safeString(json['status']),
      summarySteps: safeList(
        json['summarySteps'],
        (x) => SummaryStepsModel.fromJson(x),
      ),
      history: safeList(
        json['history'],
        (x) => TrackingHistoryModel.fromJson(x),
      ),
    );
  }
}
