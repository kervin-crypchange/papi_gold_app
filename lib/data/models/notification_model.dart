import 'package:papi_gold/app/common/utils/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.data,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: safeString(json['id']),
      data: NofiticationDataModel.fromJson(json['data']),
      createdAt: safeDateTime(json['created_at']),
    );
  }
}

class NofiticationDataModel extends NotificationDataEntity {
  const NofiticationDataModel({
    required super.title,
    required super.body,
    required super.icon,
    required super.iconColor,
    required super.status,
  });

  factory NofiticationDataModel.fromJson(Map<String, dynamic> json) {
    return NofiticationDataModel(
      title: safeString(json['title']),
      body: safeString(json['body']),
      icon: safeString(json['icon']),
      iconColor: safeString(json['iconColor']),
      status: safeString(json['status']),
    );
  }
}
