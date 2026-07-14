import 'package:equatable/equatable.dart';

class SummaryStepsEntity extends Equatable {
  final String id;
  final String label;
  final String status;

  const SummaryStepsEntity({
    required this.id,
    required this.label,
    required this.status,
  });
  
  @override
  List<Object?> get props => [id, label, status];
}
