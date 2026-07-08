import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with LoggerMixin, MessengerMixin {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
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
  List<LocationEntity> cities = [];

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    loadCountries();
  }

  void loadCountries() {
    context.read<LocationCubit>().countries().then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (c) => setState(() {
          _isLoading = false;
          countries = c;
        }),
      );
    });
  }

  void loadStates(LocationParamEntity params) {
    context.read<LocationCubit>().location(params).then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (s) => setState(() {
          _isLoading = false;
          states = s;
        }),
      );
    });
  }

  void loadCities(LocationParamEntity params) {
    context.read<LocationCubit>().location(params).then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (c) => setState(() {
          _isLoading = false;
          cities = c;
        }),
      );
    });
  }

  void _selectCountry(int c) {
    setState(() {
      _isLoading = true;
      country = c;
      loadStates(LocationParamEntity(country: c));
    });
  }

  void _selectState(int s) {
    setState(() {
      _isLoading = true;
      state = s;
      loadCities(LocationParamEntity(country: country!, state: s));
    });
  }

  void _selectCity(int c) {
    setState(() {
      city = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? LoadingWidget()
            : LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Image.asset(
                        'assets/icons/papi-gold-512x512.png',
                        height: 92.h,
                      ),
                      SizedBox(height: 16.h),
                      Text('Registro', style: context.headlineSmall),
                      Form(
                        key: _formKey,
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
                              onSaved: (value) =>
                                  setState(() => lastName = value),
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
                              onSaved: (value) =>
                                  setState(() => address1 = value),
                              validator: (value) => value?.requiredError,
                            ),
                            InputFormWidget(
                              labelText: 'Dirección 2',
                              keyboardType: TextInputType.text,
                              onSaved: (value) =>
                                  setState(() => address2 = value),
                              validator: (value) => value?.requiredError,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Seleccione país'),
                              initialValue: country,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                              ),
                              isExpanded: true,
                              items: [
                                ...countries.map(
                                  (country) => DropdownMenuItem(
                                    value: country.id,
                                    child: Text(country.name),
                                  ),
                                ),
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
                              initialValue: state,
                              items: [
                                ...states.map(
                                  (location) => DropdownMenuItem(
                                    value: location.id,
                                    child: Text(location.name),
                                  ),
                                ),
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
                              initialValue: city,
                              items: [
                                ...cities.map(
                                  (location) => DropdownMenuItem(
                                    value: location.id,
                                    child: Text(location.name),
                                  ),
                                ),
                              ],
                              onChanged: (value) => _selectCity(value!),
                            ),
                            InputFormWidget(
                              labelText: 'Código postal',
                              keyboardType: TextInputType.number,
                              onSaved: (value) =>
                                  setState(() => codeZip = value),
                              validator: (value) => value?.requiredError,
                            ),
                            InputFormWidget(
                              obscureText: obscureText,
                              labelText: 'Contraseña',
                              validator: (value) => value?.requiredError,
                              onSaved: (value) =>
                                  setState(() => password = value),
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (password! != passwordConfirmation!) {
                                      messenger.showSnackBar(
                                        message: 'Contraseñas no coinciden',
                                        color: AppColors.warning,
                                      );
                                      return;
                                    }
                                    _formKey.currentState?.save();
                                    context.read<AuthCubit>().register(
                                      RegisterEntity(
                                        name: name!,
                                        lastName: lastName!,
                                        email: email!,
                                        phone: phone!,
                                        country: country!,
                                        state: state!,
                                        city: city!,
                                        address1: address1!,
                                        address2: address2!,
                                        codeZip: codeZip!,
                                        password: password!,
                                        passwordConfirmation:
                                            passwordConfirmation!,
                                      ),
                                    );
                                  }
                                },
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
