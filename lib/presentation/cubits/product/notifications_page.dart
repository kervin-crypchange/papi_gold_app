import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Notifications Page', style: context.titleMedium),
        ),
      ),
    );
  }
}
