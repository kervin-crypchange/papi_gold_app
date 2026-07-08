import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with MessengerMixin {
  bool obscureText = true;
  String? currentPassword, password, confirmPassword;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _execute() {
    showLoading(context);

    final entity = UpdatePasswordEntity(
      currentPassword: currentPassword!,
      newPassword: password!,
      confirmNewPassword: confirmPassword!,
    );

    context.read<AuthCubit>().updatePassword(entity).then((either) {
      either.fold(
        (failure) {
          showLoading(context, false);
          messenger.showSnackBar(
            message: failure.toString(),
            color: AppColors.error,
          );
        },
        (res) {
          showLoading(context, false);
          messenger.showSnackBar(message: res, color: AppColors.success);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
      ),
      body: SafeArea(
        child: isLoading
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
                      Text(
                        'Actualizar contraseña',
                        style: context.headlineSmall,
                      ),
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
                              labelText: 'Contraseña actual',
                              validator: (value) => value?.requiredError,
                              onSaved: (value) =>
                                  setState(() => currentPassword = value),
                            ),
                            InputFormWidget(
                              obscureText: obscureText,
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: 'Nueva contraseña',
                              validator: (value) => value?.requiredError,
                              onSaved: (value) =>
                                  setState(() => password = value),
                            ),
                            InputFormWidget(
                              obscureText: obscureText,
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: 'Confirmar nueva contraseña',
                              validator: (value) => value?.requiredError,
                              onSaved: (value) =>
                                  setState(() => confirmPassword = value),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(obscureText ? 'Mostrar' : 'Ocultar'),
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
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState?.save();
                                    if (password == null ||
                                        confirmPassword == null ||
                                        currentPassword == null) {
                                      return;
                                    }
                                    if (password != confirmPassword) {
                                      messenger.showSnackBar(
                                        message: 'Contraseñas no coinciden',
                                        color: AppColors.warning,
                                      );
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                      _execute();
                                    });
                                  }
                                },
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
