import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with LoggerMixin {
  String? name,
      lastName,
      email,
      phone,
      address1,
      address2,
      codeZip,
      password,
      passwordConfirmation;

  int? country, state, city;

  bool obscureText = true;

  List<CountryEntity> countries = [];
  List<LocationEntity> states = [];
  List<LocationEntity> cities  = [];

  @override
  void initState() {
    super.initState();
    
  }

  void _selectCountry(int _country) {
    setState(() {
      country = _country;
    });
  }
  void _selectState(int _state) {
    setState(() {
      state = _state;
    });
  }
  void _selectCity(int _city) {
    setState(() {
      city = _city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Image.asset('assets/icons/papi-gold-512x512.png', height: 92.h),
                SizedBox(height: 16.h),
                Text('Registro', style: context.headlineSmall),
                Form(
                  child: Column(
                    spacing: 16.h,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        labelText: 'Correo electrónico',
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => setState(() => email = value),
                        validator: (value) => value?.requiredError,
                      ),
                      InputFormWidget(
                        labelText: 'Teléfono',
                        keyboardType: TextInputType.phone,
                        onSaved: (value) => setState(() => phone = value),
                        validator: (value) => value?.requiredError,
                      ),
                      InputFormWidget(
                        labelText: 'Dirección',
                        keyboardType: TextInputType.text,
                        onSaved: (value) => setState(() => address1 = value),
                        validator: (value) => value?.requiredError,
                      ),
                      InputFormWidget(
                        labelText: 'Dirección 2',
                        keyboardType: TextInputType.text,
                        onSaved: (value) => setState(() => address2 = value),
                        validator: (value) => value?.requiredError,
                      ),
                      InputFormWidget(
                        labelText: 'Código postal',
                        keyboardType: TextInputType.number,
                        onSaved: (value) => setState(() => codeZip = value),
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
                        items: [
                          DropdownMenuItem(value: 1, child: Text('Venezuela')),
                          DropdownMenuItem(value: 2, child: Text('Colombia')),
                          DropdownMenuItem(value: 3, child: Text('Panamá')),
                          DropdownMenuItem(value: 4, child: Text('EEUU')),
                        ],
                        onChanged: (value) => _selectCountry(value!),
                      ),
                      DropdownButtonFormField(
                        hint: Text('Seleccione estado'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                        ),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(value: 1, child: Text('Venezuela')),
                          DropdownMenuItem(value: 2, child: Text('Colombia')),
                          DropdownMenuItem(value: 3, child: Text('Panamá')),
                          DropdownMenuItem(value: 4, child: Text('EEUU')),
                        ],
                        onChanged: (value) => _selectState(value!),
                      ),
                      DropdownButtonFormField(
                        hint: Text('Seleccione ciudad'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                        ),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(value: 1, child: Text('Venezuela')),
                          DropdownMenuItem(value: 2, child: Text('Colombia')),
                          DropdownMenuItem(value: 3, child: Text('Panamá')),
                          DropdownMenuItem(value: 4, child: Text('EEUU')),
                        ],
                        onChanged: (value) => _selectCity(value!),
                      ),
                      InputFormWidget(
                        obscureText: obscureText,
                        labelText: 'Contraseña',
                        validator: (value) => value?.requiredError,
                        onSaved: (value) => setState(() => password = value),
                      ),
                      InputFormWidget(
                        obscureText: obscureText,
                        labelText: 'Confirmar contraseña',
                        validator: (value) => value?.requiredError,
                        onSaved: (value) =>
                            setState(() => passwordConfirmation = value),
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
                  ).paddingSymmetric(horizontal: 12.w, vertical: 12.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
