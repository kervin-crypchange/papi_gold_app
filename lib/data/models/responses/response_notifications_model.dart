import 'package:papi_gold/app/common/utils/index.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseNotificationsModel extends ResponseNotificationsEntity {
  const ResponseNotificationsModel({required super.data, required super.meta});

   factory ResponseNotificationsModel.fromJson(Map<String, dynamic> json) {
    return ResponseNotificationsModel(
      data: safeList(json['data'], (x)=> NotificationModel.fromJson(x)),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}
