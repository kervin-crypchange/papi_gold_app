
import 'package:get_it/get_it.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async  {
  // DIO
  sl.registerSingleton(DioClient());
}