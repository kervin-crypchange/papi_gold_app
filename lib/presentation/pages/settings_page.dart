import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/services/index.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/presentation/cubits/auth/auth_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with MessengerMixin {
  bool _isDark = true;
  bool _isLoading = false;
  bool _isLocationGranted = false;
  bool _isNotificationGranted = false;

  @override
  void initState() {
    super.initState();
    _isDark = AppThemes.themeModeNotifier.value == ThemeMode.dark;
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final isLocationGranted = await PermissionService().checkPermission(
      Permission.location,
    );
    final isNotificationGranted = await PermissionService().checkPermission(
      Permission.notification,
    );
    if (!mounted) return;
    setState(() {
      _isLocationGranted = isLocationGranted;
      _isNotificationGranted = isNotificationGranted;
    });
  }

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

  void _changeTheme() {
    AppThemes.themeModeNotifier.value = _isDark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: navBarHeight(context)),
          children: [
            _SingleSection(
              title: "General",
              children: [
                _CustomListTile(
                  title: _isDark ? "Modo diurno" : "Modo nocturno",
                  icon: _isDark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  trailing: Switch(
                    thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                      return _isDark
                          ? const Icon(
                              Icons.light_mode_outlined,
                              color: AppColors.secondary,
                            )
                          : const Icon(Icons.dark_mode_outlined);
                    }),
                    value: _isDark,
                    onChanged: (value) {
                      setState(() {
                        _isDark = value;
                        _changeTheme();
                      });
                    },
                  ),
                ),
                _CustomListTile(
                  title: "Notificaciones",
                  icon: Icons.notifications_none_rounded,
                  onTap: () => context.goNamed(Routes.notifications),
                ),
                _CustomListTile(
                  title: "Security Status",
                  icon: Icons.security_outlined,
                ),
              ],
            ),
            const Divider(),
            _SingleSection(
              title: "Organización",
              children: [
                _CustomListTile(
                  title: "Mi perfil",
                  icon: Icons.person_outline_rounded,
                  onTap: () => context.goNamed(Routes.profile),
                ),
                _CustomListTile(
                  title: "Direcciones",
                  icon: Icons.location_on_outlined,
                  onTap: () => context.goNamed(Routes.address),
                ),
                _CustomListTile(
                  title: "Cambiar contraseña",
                  icon: Icons.lock_outline,
                  onTap: () => context.goNamed(Routes.changePassword),
                ),
              ],
            ),
            const Divider(),
            _SingleSection(
              title: "Permisos",
              children: [
                _CustomListTile(
                  title: "Camara",
                  icon: Icons.camera_outlined,
                  onTap: () async =>
                      await PermissionService().openAppSettingsScreen(),
                ),
                _CustomListTile(
                  title: "Activar Ubicación",
                  icon: _isLocationGranted
                      ? Icons.location_on_outlined
                      : Icons.location_off_outlined,
                  onTap: () async =>
                      await PermissionService().openAppSettingsScreen(),
                ),
                _CustomListTile(
                  title: "Activar Notificaciones",
                  icon: _isNotificationGranted
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_off_outlined,
                  onTap: () async =>
                      await PermissionService().openAppSettingsScreen(),
                ),
              ],
            ),
            const Divider(),
            _SingleSection(
              children: [
                _CustomListTile(
                  title: "Ayuda & Feedback",
                  icon: Icons.support_agent_outlined,
                ),
                _CustomListTile(
                  title: "Acerca de",
                  icon: Icons.info_outline_rounded,
                  onTap: () => context.goNamed(Routes.about),
                ),
                _CustomListTile(
                  title: "Cerrar sesión",
                  icon: Icons.logout_outlined,
                  onTap: () async {
                    final OkCancelResult res = await showOkCancelAlertDialog(
                      title: 'Cerrar sesión',
                      message: '¿Seguro desea cerrar sesión?',
                      context: context,
                    );

                    if (res == OkCancelResult.ok) {
                      _logout();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        if (_isLoading) LoadingAnimatedWidget(),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
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
          Text(title!, style: context.labelLarge).paddingAll(8.r),
        Column(children: children),
      ],
    );
  }
}
