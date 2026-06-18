import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/responses/response_chat_entity.dart';

class ResponseMessageLogModel extends ResponseMessageLogEntity {
  const ResponseMessageLogModel({
    required super.id,
    required super.identifier,
    required super.name,
    required super.messages,
  });

  factory ResponseMessageLogModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageLogModel(
      id: safeInt(json['id']),
      identifier: safeString(json['identifier']),
      name: safeString(json['name']),
      messages: safeList<ResponseChatModel>(
        json['messages'],
        (x) => ResponseChatModel.fromJson(x as Map<String, dynamic>),
      ),
    );
  }
}

class ResponseChatModel extends ResponseChatEntity {
  const ResponseChatModel({
    required super.id,
    required super.message,
    super.fileUrl,
    required super.isOperator,
    required super.createdAt,
  });

  factory ResponseChatModel.fromJson(Map<String, dynamic> json) {
    return ResponseChatModel(
      id: safeInt(json['id']),
      message: safeString(json['message']),
      fileUrl: safeString(json['file_url']),
      isOperator: safeBool(json['is_operator']),
      createdAt: safeDateTime(json['created_at']),
    );
  }
}
