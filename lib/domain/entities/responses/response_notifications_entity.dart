import 'package:equatable/equatable.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseNotificationsEntity extends Equatable {
  final List<NotificationEntity> data;
  final MetaEntity meta;

  const ResponseNotificationsEntity({
    required this.data,
    required this.meta
  });

  @override
  List<Object?> get props => [meta, data];
}
