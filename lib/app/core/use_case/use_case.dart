import 'package:equatable/equatable.dart';

abstract class UseCase<T, Param> {
  Future<T> call({Param param});
}

/// Special class for use cases that do not require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}