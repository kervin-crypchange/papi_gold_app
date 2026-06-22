import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text('OrderPage', style: context.titleMedium)),
      ),
    );
  }
}
