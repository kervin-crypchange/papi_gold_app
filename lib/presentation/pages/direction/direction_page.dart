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
  String? address1, address2, codeZip, type, name;
  late bool isMain;
  late bool isEdit;
  List<CountryEntity> countries = [];
  List<LocationEntity> states = [];
  List<LocationEntity> cities = [];
  DirectionEntity? _direction;

  @override
  void initState() {
    _direction = context.read<DirectionsCubit>().direction;
    isMain = _direction?.isMain ?? false;
    isEdit = _direction != null;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCountries();
    });
    _selectType(_direction?.type);
  }

  void loadCountries() {
    showLoading(context);
    context.read<LocationCubit>().countries().then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (c) {
          setState(() {
            showLoading(context, false);
            countries = c;
            _selectCountry(_direction?.country.id);
          });
        },
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
          _selectState(_direction?.state.id);
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
          _selectCity(_direction?.city.id);
        }),
      );
    });
  }

  void _selectCountry(int? c) {
    if (c == null) return;
    setState(() {
      showLoading(context);
      country = c;
      loadStates(LocationParamEntity(country: c));
    });
  }

  void _selectState(int? s) {
    if (s == null) return;
    setState(() {
      showLoading(context);
      state = s;
      loadCities(LocationParamEntity(country: country!, state: s));
    });
  }

  void _selectCity(int? c) {
    if (c == null) return;
    setState(() {
      city = c;
    });
  }

  void _selectType(String? t) {
    if (t == null) return;
    setState(() {
      type = t;
    });
  }

  void _create() {
    final e = CreateUpdateDirectionEntity(
      name: name!,
      country: country!,
      state: state!,
      city: city!,
      address1: address1!,
      address2: address2!,
      codeZip: codeZip!,
      type: type!,
      isMain: isMain,
    );
    context.read<DirectionsCubit>().create(e).then((either) {
      either.fold((l) => null, (r) {
        showLoading(context, false);
        messenger.showSnackBar(
          message: 'Nueva dirección creada',
          color: AppColors.success,
        );
      });
    });
  }

  void _showMap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Key property to allow full-screen height
      useSafeArea: true, // Avoids overlapping with status/navigation bars
      builder: (BuildContext context) {
        return SizedBox(
          height: 1.sh, // Force full height
          child: Column(
            children: [
              AppBar(
                title: const Text('Full Screen Bottom Sheet'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Expanded(child: MapWidget()),
            ],
          ),
        );
      },
    );
  }

  void _edit() {
    final e = CreateUpdateDirectionEntity(
      id: _direction!.id,
      name: name!,
      country: country!,
      state: state!,
      city: city!,
      address1: address1!,
      address2: address2!,
      codeZip: codeZip!,
      type: type!,
      isMain: isMain,
    );
    context.read<DirectionsCubit>().update(e).then((either) {
      either.fold((l) => null, (r) {
        showLoading(context, false);
        messenger.showSnackBar(
          message: 'Dirección actualizada',
          color: AppColors.success,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar dirección' : 'Agregar dirección'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                spacing: 12.h,
                children: [
                  InputFormWidget(
                    initialValue: _direction?.name,
                    labelText: 'Nombre',
                    keyboardType: TextInputType.text,
                    onSaved: (value) => setState(() => name = value),
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
                    initialValue: state,
                    hint: Text('Seleccione estado'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                    isExpanded: true,
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
                    initialValue: city,
                    hint: Text('Seleccione ciudad'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                    isExpanded: true,
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
                    initialValue: _direction?.address1,
                    labelText: 'Dirección',
                    keyboardType: TextInputType.text,
                    onSaved: (value) => setState(() => address1 = value),
                    validator: (value) => value?.requiredError,
                  ),
                  InputFormWidget(
                    initialValue: _direction?.address2,
                    labelText: 'Dirección 2',
                    keyboardType: TextInputType.text,
                    onSaved: (value) => setState(() => address2 = value),
                    validator: (value) => value?.requiredError,
                  ),
                  DropdownButtonFormField(
                    initialValue: type,
                    hint: Text('Tipo de dirección'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 'shipping',
                        child: Text('Envíos'),
                      ),
                      DropdownMenuItem(
                        value: 'receiving',
                        child: Text('Receptoria'),
                      ),
                      DropdownMenuItem(value: 'both', child: Text('Ambos')),
                    ],
                    onChanged: (value) => _selectType(value!),
                  ),
                  InputFormWidget(
                    initialValue: _direction?.codeZip,
                    labelText: 'Código postal',
                    keyboardType: TextInputType.number,
                    onSaved: (value) => setState(() => codeZip = value),
                    validator: (value) => value?.requiredError,
                  ),
                  CheckboxListTile(
                    title: const Text('Establecer como dirección por defecto'),
                    value: isMain,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        isMain = value ?? false;
                      });
                    },
                  ),
                ],
              ).paddingAll(8.r),
            ),
            TextButton.icon(
              label: Text('Ubicación actual'),
              onPressed: () => _showMap(),
              icon: Icon(Icons.location_on_outlined),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: 0.9.sw,
          child: FilledButtonWidget(
            title: 'Confirmar dirección',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                showLoading(context);
                isEdit ? _edit() : _create();
              }
            },
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border(top: BorderSide.none),
      ),
    );
  }
}
