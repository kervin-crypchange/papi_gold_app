import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);

  final List<dynamic> properties;

  @override
  List<Object?> get props => [properties];
}

class LocalFailure extends Failure {
  const LocalFailure();
}

/// Represents a failure that occurs when there's no internet connection.
class NoConnectionFailure extends Failure {
  const NoConnectionFailure();
}

/// Represents a failure that occurs due to an unknown or unexpected error.
class UnknownFailure extends Failure {
  const UnknownFailure();
}