import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ResponseDirectionModel extends ResponseDirectionsEntity {
  const ResponseDirectionModel({
    required super.data,
    required super.primaryDirection,
    required super.meta,
  });

  factory ResponseDirectionModel.fromJson(Map<String, dynamic> json) {
    return ResponseDirectionModel(
      data: safeList<DirectionModel>(
        json['data'],
        (x) => DirectionModel.fromJson(x as Map<String, dynamic>),
      ),
      primaryDirection: DirectionModel.fromJson(json['primary_address']),
      meta: MetaModel.fromJson(json['meta'])
    );
  }
}
