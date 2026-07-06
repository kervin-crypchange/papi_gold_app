import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with MessengerMixin {
  bool _isDark = true;
  bool _isLoading = false;

  void _logout() {
    setState(() {
      _isLoading = true;
    });
    context.read<AuthCubit>().logout().then((either) {
      either.fold(
        (failure) => messenger.showSnackBar(
          message: failure.toString(),
          color: AppColors.error,
        ),
        (res) {
          setState(() {
            _isLoading = false;
            context.goNamed(Routes.login);
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 70.h),
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: _isDark,
                      onChanged: (value) {
                        setState(() {
                          _isDark = value;
                        });
                      },
                    ),
                    onTap: () => null,
                  ),
                  _CustomListTile(
                    title: "Notifications",
                    icon: Icons.notifications_none_rounded,
                    onTap: () => null,
                  ),
                  _CustomListTile(
                    title: "Security Status",
                    icon: Icons.security_outlined,
                    onTap: () => null,
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                title: "Organización",
                children: [
                   _CustomListTile(
                    title: "Profile",
                    icon: Icons.person_outline_rounded,
                    onTap: () => null,
                  ),
                  _CustomListTile(
                    title: "Help & Feedback",
                    icon: Icons.help_outline_rounded,
                    onTap: () => null,
                  ),
                  _CustomListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                    onTap: () => null,
                  ),
                  _CustomListTile(
                    title: "Sign out",
                    icon: Icons.exit_to_app_rounded,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Cerrar sesión'),
                            content: const Text(
                              'Are you sure you want to proceed?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Timer(
                                    Duration(milliseconds: 200),
                                    () => _logout(),
                                  );
                                },
                                child: const Text('Confirmar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          if (_isLoading) LoadingWidget(),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function() onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.bodyLarge,
            // style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ).paddingAll(8.r),
        Column(children: children),
      ],
    );
  }
}
