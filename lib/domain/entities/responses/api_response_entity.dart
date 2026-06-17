import 'package:equatable/equatable.dart';

class ApiResponseEntity<T> extends Equatable{
  final List<T> data;

  const ApiResponseEntity({required this.data});
  @override
  List<Object?> get props => [data];
}