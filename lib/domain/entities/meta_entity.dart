import 'package:equatable/equatable.dart';

class MetaEntity extends Equatable {
  final int currentPage;
  final int lastpage;
  final int perPege;
  final int total;

  const MetaEntity({
    required this.currentPage,
    required this.lastpage,
    required this.perPege,
    required this.total,
  });
  
  @override
  List<Object?> get props => [currentPage, lastpage, perPege, total];
}
