import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/stats_entity.dart';

class StatsModel extends StatsEntity {
  const StatsModel({required super.invested, required super.sold});

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      invested: StatsDataModel.fromJson(
        json['invested']
      ),
      sold: StatsDataModel.fromJson(json['sold']),
    );
  }
}

class StatsDataModel extends StatsDataEntity {
  const StatsDataModel({required super.amount, required super.count});

  factory StatsDataModel.fromJson(Map<String, dynamic> json) {
    return StatsDataModel(
      amount: safeDouble(json['amount']),
      count: safeInt(json['count']),
    );
  }
}
