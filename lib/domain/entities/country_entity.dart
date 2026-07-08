import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final int id;
  final String name;
  final String phoneCode;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.phoneCode,
  });
  @override
  List<Object?> get props => [id, name, phoneCode];
}
