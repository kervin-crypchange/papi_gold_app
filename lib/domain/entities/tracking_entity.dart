import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class TrackingEntity extends Equatable {
  final String trackingNumber;
  final String status;
  final List<SummaryStepsEntity> summarySteps;
  final List<TrackingHistoryEntity> history;
  final String addressShipping;

  const TrackingEntity({
    required this.trackingNumber,
    required this.status,
    required this.summarySteps,
    required this.history,
    required this.addressShipping,
  });

  @override
  List<Object?> get props => [
    trackingNumber,
    status,
    summarySteps,
    history,
    addressShipping,
  ];
}
