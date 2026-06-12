import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({super.key});

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage>
    with LoggerMixin {
  String? email;

  @override
  void initState() {
    super.initState();
  }

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
                spacing: 16.h,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recuperar Contraseña', style: context.headlineSmall),
                  InputFormWidget(
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => setState(() => email = value),
                    validator: (value) =>
                        value?.requiredError ?? value?.emailError,
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: FilledButtonWidget(
                      onPressed: () => log('press me'),
                      title: 'Enviar',
                    ),
                  ),
                  InkWell(
                    onTap: () => context.goNamed('login'),
                    child: Text('Iniciar sesión'),
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
    );
  }
}
