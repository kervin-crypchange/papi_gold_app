import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/mixins/logger_mixin.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/uses_cases/auth.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';
import 'package:papi_gold/injection_container.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with LoggerMixin {
  Map<String, dynamic>? _data;

  AuthCubit() : super(AuthInitial());

  void login(LoginEntity entity) async {
    emit(AuthLoading());
    Either res = await sl<LoginUseCase>().call(param: entity);
    res.fold((l) => emit(AuthError(message: l.message)), (r) {
      try {
        sl<AuthLocalData>().saveToken(r.token);
        sl<AuthLocalData>().saveRefreshToken(r.refreshToken);
        sl<AuthLocalData>().setIsLogged(true);
      } catch (_) {}
      emit(AuthSuccess(response: r));
    });
  }

  Future<Either<Failure, ResponseRegisterEntity>> register(
    RegisterEntity entity,
  ) async {
    return await sl<RegisterUseCase>().call(param: entity);
  }

  Future<Either<Failure, LogoutEntity>> logout() async {
    return await sl<LogoutUseCase>().call();
  }

  Future<Either<Failure, String>> updatePassword(UpdatePasswordEntity e) async {
    return await sl<UpdatePasswordUseCase>().call(param: e);
  }

  bool isLogged() {
    return sl<AuthLocalData>().getIsLogged();
  }

  void setOtpdata(Map<String, dynamic> data) {
    _data = data;
  }

  Map<String, dynamic> get data => _data!;
}
