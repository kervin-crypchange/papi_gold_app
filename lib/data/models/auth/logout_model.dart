
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class LogoutModel extends LogoutEntity {
  const LogoutModel({required super.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(message: safeString(json['message']));
  }
}
