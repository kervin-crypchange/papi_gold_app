

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoggerMixin {
  String? email, password;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            child: Container(
              height: .45.sh,
              width: .9.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: BoxBorder.all(color: AppColors.white, width: 0.5),
              ),
              child: Column(
                spacing: 10.h,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Iniciar Sesión', style: context.headlineSmall),
                  InputFormWidget(
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => setState(() => email = value),
                    validator: (value) =>
                        value?.requiredError ?? value?.emailError,
                  ),
                  InputFormWidget(
                    obscureText: obscureText,
                    prefixIcon: Icon(Icons.lock_outline),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    labelText: 'Contraseña',
                    // helperText:
                    //     'Minimum 6 characters, uppercase, lowercase letter and a number',
                    validator: (value) => value?.requiredError,
                    onSaved: (value) => setState(() => password = value),
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: FilledButtonWidget(
                      onPressed: () => log('press me'),
                      title: 'Iniciar sesión',
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.goNamed('recovery'),
                    child: Text('¿Olvido su contraseña?'),
                  ),
                  TextButton(
                    onPressed: () => context.goNamed('register'),
                    child: Text('¿No tienes cuenta?, registrate'),
                  ),
                ],
              ).paddingSymmetric(horizontal: 24.w),
            ),
          ),
        ),
      ),
    );
  }
}
