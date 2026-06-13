
import 'package:get_it/get_it.dart';
import 'package:papi_gold/app/core/network/dio_client.dart';

import 'package:papi_gold/data/sources/remote/auth/auth_data_impl.dart';
import 'package:papi_gold/data/sources/local/auth_local_data_impl.dart';
import 'package:papi_gold/data/repositories/auth_repository_impl.dart';

import 'package:papi_gold/data/sources/remote/auth/auth_data.dart';
import 'package:papi_gold/data/sources/local/auth_local_data.dart';
import 'package:papi_gold/domain/repositories/auth_repository.dart';
import 'package:papi_gold/domain/uses_cases/login_usecase.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async  {
  // DIO
  sl.registerSingleton(DioClient());

  // Data sources
  sl.registerLazySingleton<AuthData>(() => AuthDataImpl());
  sl.registerLazySingleton<AuthLocalData>(() => AuthLocalDataImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(data: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), localData: sl()));
}