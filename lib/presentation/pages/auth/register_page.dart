import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/filled_button_widget.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with LoggerMixin {
  String? name, lastName, email, password, phone, country;
  String? selectedCountry;
  bool obscureText = true;
  final List<String> _countries = [
    'Venezuela',
    'Colombia',
    'Panama',
    'Estados Unidos',
  ];

  void _selectCountry(String c) {
    setState(() {
      country = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            child: Column(
              spacing: 16.h,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Registro', style: context.headlineSmall),
                InputFormWidget(
                  labelText: 'Nombre',
                  keyboardType: TextInputType.text,
                  onSaved: (value) => setState(() => name = value),
                  validator: (value) => value?.requiredError,
                ),
                InputFormWidget(
                  labelText: 'Apellido',
                  keyboardType: TextInputType.text,
                  onSaved: (value) => setState(() => lastName = value),
                  validator: (value) => value?.requiredError,
                ),
                InputFormWidget(
                  labelText: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => setState(() => lastName = value),
                  validator: (value) => value?.requiredError,
                ),
                DropdownButtonFormField(
                  hint: Text('Seleccione país'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                  ),
                  isExpanded: true,
                  items: _countries
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) => _selectCountry(value!),
                ),
                InputFormWidget(
                  labelText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => setState(() => email = value),
                  validator: (value) =>
                      value?.requiredError ?? value?.emailError,
                ),
                InputFormWidget(
                  obscureText: obscureText,
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
                  validator: (value) => value?.requiredError,
                  onSaved: (value) => setState(() => password = value),
                ),
                SizedBox(
                  width: 1.sw,
                  child: FilledButtonWidget(
                    onPressed: () => log('press me'),
                    title: 'Registrar',
                  ),
                ),
                InkWell(
                  onTap: () => context.goNamed('login'),
                  child: Text('Iniciar sesión'),
                ),
              ],
            ).paddingSymmetric(horizontal: 24.w, vertical: 12.h),
          ),
        ),
      ),
    );
  }
}
