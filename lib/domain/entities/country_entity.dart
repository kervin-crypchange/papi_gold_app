import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final int id;
  final String name;
  final String iso2;
  final String phoneCode;
  final String emoji;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.iso2,
    required this.phoneCode,
    required this.emoji,
  });
  @override
  List<Object?> get props => [id, name, iso2, phoneCode, emoji];
}
