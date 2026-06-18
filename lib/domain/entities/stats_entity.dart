import 'package:equatable/equatable.dart';

class StatsEntity extends Equatable {
  final StatsDataEntity invested;
  final StatsDataEntity sold;

  const StatsEntity({required this.invested, required this.sold});
  @override
  List<Object?> get props => [sold, invested];
}

class StatsDataEntity extends Equatable {
  final double amount;
  final int count;

  const StatsDataEntity({required this.amount, required this.count});
  @override
  List<Object?> get props => [amount, count];
}
