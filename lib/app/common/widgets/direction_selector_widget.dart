import 'package:flutter/material.dart';
import 'package:papi_gold/domain/entities/direction_entity.dart';

class DirectionSelectorWidget extends StatefulWidget {
  const DirectionSelectorWidget({super.key});

  @override
  State<DirectionSelectorWidget> createState() => _DirectionSelectorWidgetState();
}

class _DirectionSelectorWidgetState extends State<DirectionSelectorWidget> {
  
  List<DirectionEntity> directions = [];

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}