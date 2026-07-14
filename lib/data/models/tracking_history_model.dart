import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class TrackingHistoryModel extends TrackingHistoryEntity {
  const TrackingHistoryModel({
    required super.id,
    required super.date,
    required super.status,
    required super.location,
  });

  factory TrackingHistoryModel.fromJson(Map<String, dynamic> json) {
    return TrackingHistoryModel(
      id: safeString(json['id']),
      date: safeString(json['date']),
      status: safeString(json['status']),
      location: safeString(json['direction']),
    );
  }
}
