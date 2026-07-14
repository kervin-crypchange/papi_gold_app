import 'package:equatable/equatable.dart';

class TrackingHistoryEntity extends Equatable {
  final String id;
  final String date;
  final String status;
  final String location;

  const TrackingHistoryEntity({
    required this.id,
    required this.date,
    required this.status,
    required this.location,
  });

  @override
  List<Object?> get props => [id, date, status, location];
}
