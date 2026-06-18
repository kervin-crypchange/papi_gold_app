import 'package:papi_gold/domain/entities/chat_payload_entity.dart';

class ChatPayloadModel extends ChatPayloadEntity {
  const ChatPayloadModel({
    required super.identifier,
    required super.message,
    super.file,
    super.name,
    super.email,
    super.phone,
    super.orderId,
  });

  Map<String, dynamic> toJson(){
    return {
      'identifier': identifier,
      'message': message,
      'file': file,
      'name': name,
      'phone': phone,
      'order_id': orderId
    };
  }
}
