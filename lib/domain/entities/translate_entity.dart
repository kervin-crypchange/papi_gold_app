import 'package:equatable/equatable.dart';

class TranslationEntity extends Equatable {
  final TranslateEntity es;
  final TranslateEntity en;

  const TranslationEntity({required this.en, required this.es});

  @override
  List<Object?> get props => [es, en];
}

class TranslateEntity extends Equatable {
  final String name;
  final String description;

  const TranslateEntity({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}
