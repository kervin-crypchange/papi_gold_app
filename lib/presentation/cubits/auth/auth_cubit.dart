import 'package:bloc/bloc.dart';
import 'package:papi_gold/data/models/client_model.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';
import 'package:papi_gold/domain/uses_cases/login_usecase.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/sources/local/auth_local_data.dart';
import 'package:papi_gold/domain/entities/responses/response_login_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final AuthLocalData localData;

  AuthCubit({required this.loginUseCase, required this.localData}) : super(AuthInitial());

  Future<void> login(LoginEntity params) async {
    emit(AuthLoading());
    final res = await loginUseCase.call(params);
    res.fold((Failure l) {
      emit(AuthError(message: l.toString()));
    }, (ResponseLoginEntity r) {
      try {
        localData.saveToken(r.token);
        localData.saveUserLogged(ClientModel.fromEntity(r.client));
      } catch (_) {}
      emit(AuthSuccess(response: r));
    });
  }
}
