import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/pages/navigation_page.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isLogged = context.read<AuthCubit>().isLogged();
    return isLogged ? NavigationPage() : LoginPage();
  }
}
