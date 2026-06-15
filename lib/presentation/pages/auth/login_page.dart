import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoggerMixin, MessengerMixin {
  String? email, password;
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                log(state.message);
                messenger.showSnackBar(message: state.message, color: AppColors.error);
              } else if (state is AuthSuccess) {
                messenger.showSnackBar(message: state.response.message, color: AppColors.success);
              }
            },
            child: Form(
              key: _formKey,
              child: Container(
                height: .45.sh,
                width: .9.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: BoxBorder.all(color: AppColors.white, width: 0.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.h,
                  children: [
                    Text('Iniciar Sesión', style: context.headlineSmall),
                    InputFormWidget(
                      prefixIcon: Icon(Icons.mail_outline),
                      labelText: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => setState(() => email = value),
                      validator: (value) => value?.requiredError ?? value?.emailError,
                    ),
                    InputFormWidget(
                      obscureText: obscureText,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffix: InkWell(
                        onTap: () => setState(() => obscureText = !obscureText),
                        child: obscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      ),
                      labelText: 'Contraseña',
                      validator: (value) => value?.requiredError,
                      onSaved: (value) => setState(() => password = value),
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: FilledButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            if (email != null && password != null) {
                              context.read<AuthCubit>().login(
                                LoginEntity(email: email!, password: password!),
                              );
                            }
                          }
                        },
                        title: 'Iniciar sesión',
                      ),
                    ),
                    InkWell(
                      onTap: () => context.goNamed('recovery'),
                      child: Text('¿Olvido su contraseña?'),
                    ),
                    InkWell(
                      onTap: () => context.goNamed('register'),
                      child: Text('¿No tienes cuenta?, registrate'),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24.w),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
