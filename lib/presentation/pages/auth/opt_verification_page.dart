import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/store/client/persistent_client_data.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';

class OptVerificationPage extends StatefulWidget {
  final OptTypeEnum type;
  const OptVerificationPage({super.key, required this.type});

  @override
  State<OptVerificationPage> createState() => _OptVerificationPageState();
}

class _OptVerificationPageState extends State<OptVerificationPage> {
  final String email = PersistentClientData().getEmail();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
      ),
      body: SafeArea(
        child: LogoWithTitle(
          title: 'Código OTP',
          subText: "El código de verificación ha sido enviado a tu correo",
          children: [
            Text(email),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            OtpForm(type: widget.type,),
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  final OptTypeEnum type;
  const OtpForm({super.key, required this.type});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with MessengerMixin {
  final _formKey = GlobalKey<FormState>();
  final List<TextInputFormatter> otpTextInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(1),
  ];
  late FocusNode _pin1Node;
  late FocusNode _pin2Node;
  late FocusNode _pin3Node;
  late FocusNode _pin4Node;
  late FocusNode _pin5Node;
  late FocusNode _pin6Node;

  String? pin1, pin2, pin3, pin4, pin5, pin6;

  @override
  void initState() {
    super.initState();
    _pin1Node = FocusNode();
    _pin2Node = FocusNode();
    _pin3Node = FocusNode();
    _pin4Node = FocusNode();
    _pin5Node = FocusNode();
    _pin6Node = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _pin1Node.dispose();
    _pin2Node.dispose();
    _pin3Node.dispose();
    _pin4Node.dispose();
    _pin5Node.dispose();
    _pin6Node.dispose();
  }

  void _updatePassword(String otp) {
    showLoading(context);
    final Map<String, dynamic> data = context.read<AuthCubit>().data;
    data['verificationCode'] = otp;
    final UpdatePasswordEntity entity = UpdatePasswordModel.fromJson(data);

    context.read<AuthCubit>().updatePassword(entity).then((either) {
      either.fold((failure) => null, (res) {
        showLoading(context, false);
        messenger.showSnackBar(message: res, color: AppColors.success);
        context.goNamed(Routes.navigation);
      });
    });
  }

  void _updateClientData(String otp) {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin1Node,
                  onChanged: (value) {
                    if (value.length == 1) _pin2Node.requestFocus();
                  },
                  onSaved: (pin) {
                    setState(() {
                      pin1 = pin;
                    });
                  },
                  autofocus: true,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin2Node,
                  onChanged: (value) {
                    if (value.length == 1) _pin3Node.requestFocus();
                  },
                  onSaved: (pin) {
                    setState(() {
                      pin2 = pin;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin3Node,
                  onChanged: (value) {
                    if (value.length == 1) _pin4Node.requestFocus();
                  },
                  onSaved: (pin) {
                    setState(() {
                      pin3 = pin;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin4Node,
                  onChanged: (value) {
                    if (value.length == 1) _pin5Node.requestFocus();
                  },
                  onSaved: (pin) {
                    setState(() {
                      pin4 = pin;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin5Node,
                  onChanged: (value) {
                    if (value.length == 1) _pin6Node.requestFocus();
                  },
                  onSaved: (pin) {
                    setState(() {
                      pin5 = pin;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OtpTextFormField(
                  focusNode: _pin6Node,
                  onSaved: (pin) {
                    setState(() {
                      pin6 = pin;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: 0.9.sw,
            child: FilledButtonWidget(
              title: 'Enviar',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final String otp = '$pin1$pin2$pin3$pin4$pin5$pin6';
                  (widget.type == OptTypeEnum.updatePassword)
                      ? _updatePassword(otp)
                      : _updateClientData(otp);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const InputDecoration otpInputDecoration = InputDecoration(
  filled: false,
  border: UnderlineInputBorder(),
  hintText: "0",
);

class OtpTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final bool autofocus;

  const OtpTextFormField({
    super.key,
    this.focusNode,
    this.onChanged,
    this.onSaved,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onChanged: onChanged,
      onSaved: onSaved,
      autofocus: autofocus,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1),
      ],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: otpInputDecoration,
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle({
    super.key,
    required this.title,
    this.subText = '',
    required this.children,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Image.asset('assets/icons/papi-gold-512x512.png', height: 92.h),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: double.infinity,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color!.withValues(alpha: 0.64),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
          );
        },
      ),
    );
  }
}
