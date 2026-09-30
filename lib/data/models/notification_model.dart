import 'package:papi_gold/app/common/utils/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.data,
    required super.createdAt,
    super.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: safeString(json['id']),
      data: NotificationDataModel.fromJson(json['data']),
      createdAt: safeDateTime(json['created_at']),
      readAt: json['read_at'] != null ? safeDateTime(json['read_at']) : null,
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity e) {
    return NotificationModel(
      id: e.id,
      data: NotificationDataModel.fromEntity(e.data),
      createdAt: e.createdAt,
      readAt: e.readAt != null ? e.createdAt : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': NotificationDataModel.fromEntity(data).toJson(),
      'created_at': createdAt,
    };
  }
}

class NotificationDataModel extends NotificationDataEntity {
  const NotificationDataModel({
    required super.title,
    required super.body,
    required super.icon,
    required super.iconColor,
    required super.status,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      title: safeString(json['title']),
      body: safeString(json['body']),
      icon: safeString(json['icon']),
      iconColor: safeString(json['iconColor']),
      status: safeString(json['status']),
    );
  }

  factory NotificationDataModel.fromEntity(NotificationDataEntity e) {
    return NotificationDataModel(
      title: e.title,
      body: e.body,
      icon: e.icon,
      iconColor: e.iconColor,
      status: e.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'icon': icon,
      'iconColor': iconColor,
      'status': status,
    };
  }
}
