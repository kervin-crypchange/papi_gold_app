import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/index.dart';

class TranslationModel extends TranslationEntity {
  const TranslationModel({required super.en, required super.es});

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      en: TranslateModel.fromJson(json['en'] as Map<String, dynamic>),
      es: TranslateModel.fromJson(json['es'] as Map<String, dynamic>),
    );
  }
}

class TranslateModel extends TranslateEntity {
  const TranslateModel({required super.name, required super.description});

  factory TranslateModel.fromJson(Map<String, dynamic> json) {
    return TranslateModel(
      name: safeString(json['name']),
      description: safeString(json['description']),
    );
  }
  factory TranslateModel.fromEntity(TranslateEntity e) {
    return TranslateModel(name: e.name, description: e.description);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }
}
