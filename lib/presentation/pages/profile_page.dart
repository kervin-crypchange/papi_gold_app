import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDark = true;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 70.h),
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
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
                    ),
                    const _CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded,
                    ),
                    const _CustomListTile(
                      title: "Security Status",
                      icon: Icons.security_outlined,
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  title: "Organization",
                  children: [
                    _CustomListTile(
                      title: "Profile",
                      icon: Icons.person_outline_rounded,
                    ),
                    _CustomListTile(
                      title: "Messaging",
                      icon: Icons.message_outlined,
                    ),
                    _CustomListTile(
                      title: "Calling",
                      icon: Icons.phone_outlined,
                    ),
                    _CustomListTile(
                      title: "People",
                      icon: Icons.contacts_outlined,
                    ),
                    _CustomListTile(
                      title: "Calendar",
                      icon: Icons.calendar_today_rounded,
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  children: [
                    _CustomListTile(
                      title: "Help & Feedback",
                      icon: Icons.help_outline_rounded,
                    ),
                    _CustomListTile(
                      title: "About",
                      icon: Icons.info_outline_rounded,
                    ),
                    _CustomListTile(
                      title: "Sign out",
                      icon: Icons.exit_to_app_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
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
