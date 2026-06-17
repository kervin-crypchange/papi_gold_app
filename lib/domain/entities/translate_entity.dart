import 'package:equatable/equatable.dart';

class TranslateEntity extends Equatable{
  final String name;
  final String description;

  const TranslateEntity({ required this.name, required this.description});
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, description];
}