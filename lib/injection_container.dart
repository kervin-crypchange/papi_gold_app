import 'package:get_it/get_it.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';
import 'package:papi_gold/data/sources/remote/index.dart';

import 'package:papi_gold/data/sources/local/index.dart';
import 'package:papi_gold/data/repositories/index.dart';

import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/domain/uses_cases/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:papi_gold/presentation/cubits/prices/prices_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // DIO
  sl.registerSingleton(DioClient());

  // Data sources
  sl.registerLazySingleton<AuthData>(() => AuthDataImpl());
  sl.registerLazySingleton<AuthLocalData>(() => AuthLocalDataImpl());
  sl.registerLazySingleton<CommonRemoteData>(() => CommonRemoteDataImpl());
  sl.registerLazySingleton<AppSocketSource>(() => AppSocketSourceImpl());
  sl.registerLazySingleton<DirectionRemoteData>(() => DirectionRemoteDataImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerLazySingleton<CommonRepository>(() => CommonRepositoryImpl());
  sl.registerLazySingleton<AppSocketRespository>(() => AppSocketRepositoryImpl());
  sl.registerLazySingleton<DirectionRepository>(() => DirectionRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase());
  sl.registerLazySingleton(() => RegisterUseCase());
  sl.registerLazySingleton(() => LogoutUseCase());
  sl.registerLazySingleton(() => UpdatePasswordUseCase());
  sl.registerLazySingleton(() => OrdersUseCase());
  sl.registerLazySingleton(() => OrderUseCase());
  sl.registerLazySingleton(() => ProductsUseCase());
  sl.registerLazySingleton(() => ProductUseCase());
  sl.registerLazySingleton(() => CheckOutUseCase());
  sl.registerLazySingleton(() => PaymentUseCase());
  sl.registerLazySingleton(() => CountriesUseCase());
  sl.registerLazySingleton(() => LocationUseCase());
  sl.registerLazySingleton(() => TrackingUseCase());
  sl.registerLazySingleton(() => StreamMessagesUseCase());
  sl.registerLazySingleton(() => ConnectSocketUseCase());
  sl.registerLazySingleton(() => DisconnectSocketUseCase());
  sl.registerLazySingleton(() => DirectionsUseCase());
  sl.registerLazySingleton(() => DeleteDirectionUseCase());
  sl.registerLazySingleton(() => UpdateDirectionUseCase());
  sl.registerLazySingleton(() => CreateDirectionUseCase());
  sl.registerLazySingleton(() => MapNamesUseCase());
  sl.registerLazySingleton(() => PricesUseCase());

  // Cubits
  sl.registerFactory(() => AuthCubit());
  sl.registerFactory(() => OrdersCubit());
  sl.registerFactory(() => ProductCubit());
  sl.registerFactory(() => CheckOutCubit());
  sl.registerFactory(() => PaymentCubit());
  sl.registerFactory(() => LocationCubit());
  sl.registerFactory(() => TrackingCubit());
  sl.registerFactory(() => AppSocketCubit());
  sl.registerFactory(() => DirectionsCubit());
  sl.registerFactory(() => PricesCubit());
}
