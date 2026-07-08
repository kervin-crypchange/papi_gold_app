import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({super.key});

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage>
    with LoggerMixin {
  String? email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Image.asset('assets/icons/papi-gold-512x512.png', height: 92.h),
                SizedBox(height: constraints.maxHeight * 0.1),
                Text('Recuperar contraseña', style: context.headlineSmall),
                SizedBox(height: constraints.maxHeight * 0.05),

                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16.h,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        child: Text('¿No tienes cuenta?. Registrate'),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 12.w),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
