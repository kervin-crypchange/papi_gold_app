import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseRegisterModel extends ResponseRegisterEntity {
  const ResponseRegisterModel({
    required super.message,
    super.status,
  });

  factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) {
    return ResponseRegisterModel(
      message: safeString(json['message']),
      status: safeString(json['status']),
    );
  }
  
}
