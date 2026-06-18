import 'package:papi_gold/domain/entities/index.dart';

class ConsultationPayloadModel extends ConsultationPayloadEntity {
  const ConsultationPayloadModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.type,
    required super.details,
  });

  factory ConsultationPayloadModel.fromEntity(ConsultationPayloadEntity e) {
    return ConsultationPayloadModel(
      name: e.name,
      email: e.email,
      phone: e.phone,
      type: e.type,
      details: e.details,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'email': email,
      'phone': phone,
      'type': type,
      'details': details,
    };
  }
}
