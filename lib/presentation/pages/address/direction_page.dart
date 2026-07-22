import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class DirectionPage extends StatefulWidget {
  const DirectionPage({super.key});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> with MessengerMixin {
  final _formKey = GlobalKey<FormState>();
  int? country, state, city;
  String? address1, address2, codeZip;
  List<CountryEntity> countries = [];
  List<LocationEntity> states = [];
  List<LocationEntity> cities = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoading(context);
    });
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
          showLoading(context, false);
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
          showLoading(context, false);
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
          showLoading(context, false);
          cities = c;
        }),
      );
    });
  }

  void _selectCountry(int c) {
    debugPrint('country $c');
    setState(() {
      showLoading(context);
      country = c;
      loadStates(LocationParamEntity(country: c));
    });
  }

  void _selectState(int s) {
    debugPrint('state $s');

    setState(() {
      showLoading(context);
      state = s;
      loadCities(LocationParamEntity(country: country!, state: s));
    });
  }

  void _selectCity(int c) {
    debugPrint('city $c');

    setState(() {
      city = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar dirección')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                spacing: 12.h,
                children: [
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
                ],
              ).paddingAll(8.r),
            ),
            // TextButton(
            //   onPressed: () => context.goNamed(Routes.map),
            //   child: Wrap(
            //     spacing: 6.w,
            //     children: [
            //       Icon(Icons.location_on_outlined),
            //       Text(
            //         'Ubicación actual',
            //         style: TextStyle(decoration: TextDecoration.underline),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: 0.9.sw,
          child: FilledButtonWidget(
            title: 'Confirmar dirección',
            onPressed: () {},
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border(top: BorderSide.none),
      ),
    );
  }
}
