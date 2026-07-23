import 'package:papi_gold/domain/entities/index.dart';

class CreateUpdateDirectionModel extends CreateUpdateDirectionEntity {
  const CreateUpdateDirectionModel({
    super.id,
    required super.name,
    required super.country,
    required super.state,
    required super.city,
    required super.address1,
    required super.address2,
    required super.codeZip,
    required super.type,
    required super.isMain,
  });

  factory CreateUpdateDirectionModel.fromEntity(CreateUpdateDirectionEntity e){
    return CreateUpdateDirectionModel(
      id: e.id,
      name: e.name,
      country: e.country,
      state: e.state,
      city: e.city,
      address1: e.address1,
      address2: e.address1,
      codeZip: e.codeZip,
      type: e.type,
      isMain: e.isMain,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'code_zip': codeZip,
      'type': type,
      'is_default': isMain,
    };
  }
}
