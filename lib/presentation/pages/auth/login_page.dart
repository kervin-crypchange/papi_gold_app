import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/domain/entities/auth/login_entity.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessengerMixin {
  String? email, password;
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              log('--- Login');
              showLoading(context, false);
              await Future.delayed(Durations.long1, () {
                if (context.mounted) {
                  context.goNamed(Routes.navigation);
                }
              });
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Image.asset(
                      'assets/icons/papi-gold-512x512.png',
                      height: 92.h,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Text('Iniciar sesión', style: context.headlineSmall),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12.h,
                        children: [
                          InputFormWidget(
                            prefixIcon: Icon(Icons.mail_outline),
                            labelText: 'Correo electrónico',
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) => setState(() => email = value),
                            validator: (value) =>
                                value?.requiredError ?? value?.emailError,
                          ),
                          InputFormWidget(
                            obscureText: obscureText,
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: 'Contraseña',
                            validator: (value) => value?.requiredError,
                            onSaved: (value) =>
                                setState(() => password = value),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(obscureText ? 'Mostrar' : 'Ocultar'),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: obscureText,
                                  onChanged: (value) {
                                    setState(() {
                                      obscureText = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 1.sw,
                            child: FilledButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  showLoading(context);
                                  context.read<AuthCubit>().login(
                                    LoginEntity(
                                      email: email!,
                                      password: password!,
                                    ),
                                  );
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
                            onTap: () => context.goNamed(Routes.register),
                            child: Text('¿No tienes cuenta?.  Registrate'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
