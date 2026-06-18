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

  factory ChatPayloadModel.fromEntity(ChatPayloadEntity e) {
    return ChatPayloadModel(
      identifier: e.identifier,
      message: e.message,
      file: e.file,
      name: e.name,
      email: e.email,
      phone: e.phone,
      orderId: e.orderId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'message': message,
      'file': file,
      'name': name,
      'phone': phone,
      'order_id': orderId,
    };
  }
}
