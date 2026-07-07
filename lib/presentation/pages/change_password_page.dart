import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool obscureText = true;
  String? password, confirmPassword;
  final _formKey = GlobalKey<FormState>();

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
                Text('Actualizar contraseña', style: context.headlineSmall),
                SizedBox(height: constraints.maxHeight * 0.05),

                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16.h,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputFormWidget(
                        obscureText: obscureText,
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Contraseña',
                        validator: (value) => value?.requiredError,
                        onSaved: (value) => setState(() => password = value),
                      ),
                      InputFormWidget(
                        obscureText: obscureText,
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Confirmar contraseña',
                        validator: (value) => value?.requiredError,
                        onSaved: (value) =>
                            setState(() => confirmPassword = value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            obscureText
                                ? 'Mostrar contraseña'
                                : 'Ocultar contraseña',
                          ),
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
                          onPressed: () => debugPrint('press me'),
                          title: 'Actualizar',
                        ),
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
