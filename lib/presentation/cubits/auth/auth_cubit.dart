import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';
import 'package:papi_gold/domain/uses_cases/auth.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';
import 'package:papi_gold/injection_container.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(LoginEntity model) async {
    emit(AuthLoading());
    Either res = await sl<LoginUseCase>().call(param: model);
    res.fold(
      (l) {
        emit(AuthError(message: l.toString()));
      },
      (r) {
        try {
          sl<AuthLocalData>().saveToken(r.token);
          sl<AuthLocalData>().saveUserLogged(ClientModel.fromEntity(r.client));
        } catch (_) {}
        emit(AuthSuccess(response: r));
      },
    );
  }
}
