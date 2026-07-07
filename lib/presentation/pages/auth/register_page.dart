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
        (_countries) => setState(() {
          _isLoading = false;
          countries = _countries;
        }),
      );
    });
  }

  void loadStates(LocationParamEntity params) {
    print(params);
    context.read<LocationCubit>().location(params).then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (_states) => setState(() {
          _isLoading = false;
          states = _states;
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
        (_cities) => setState(() {
          _isLoading = false;
          cities = _cities;
        }),
      );
    });
  }

  void _selectCountry(int _country) {
    setState(() {
      _isLoading = true;
      country = _country;
      loadStates(LocationParamEntity(country: _country));
    });
  }

  void _selectState(int _state) {
    setState(() {
       _isLoading = true;
      state = _state;
      loadCities(LocationParamEntity(country: country!, state: _state));
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
                            InputFormWidget(
                              labelText: 'Código postal',
                              keyboardType: TextInputType.number,
                              onSaved: (value) =>
                                  setState(() => codeZip = value),
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
