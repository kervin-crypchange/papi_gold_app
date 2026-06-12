import 'package:equatable/equatable.dart';

class RecoveryEntity extends Equatable{
  final String email;

  const RecoveryEntity({required this.email});
  
  @override
  List<Object?> get props => [email];
}