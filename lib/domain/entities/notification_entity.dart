import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final NotificationDataEntity data;
  final DateTime createdAt;
  final DateTime? readAt;

  const NotificationEntity({
    required this.id,
    required this.data,
    required this.createdAt,
    this.readAt,
  });

  @override
  List<Object?> get props => [id, data, createdAt, readAt];
}

class NotificationDataEntity extends Equatable {
  final String title;
  final String body;
  final String icon;
  final String iconColor;
  final String status;


  const NotificationDataEntity({
    required this.title,
    required this.body,
    required this.icon,
    required this.iconColor,
    required this.status,

  });

  @override
  List<Object?> get props => [icon, body, title, icon, status, iconColor];
}
