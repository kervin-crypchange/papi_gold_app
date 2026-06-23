
import 'package:equatable/equatable.dart';

class StatusEntity extends Equatable {
  final String name;
  final String? color;

  const StatusEntity({required this.name, this.color});

  @override
  List<Object?> get props => [name, color];
}