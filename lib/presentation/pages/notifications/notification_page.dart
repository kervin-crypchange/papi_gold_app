import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/text_style.dart';
import 'package:papi_gold/app/core/extensions/widget.dart';
import 'package:papi_gold/presentation/cubits/index.dart';

class NotificationPage extends StatefulWidget {
  final String id;
  final Map<String, dynamic> not;
  const NotificationPage({super.key, required this.not, required this.id});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    if (widget.not['readAt'] == null) {
      context.read<NotificationsCubit>().maskAsRead(widget.id);
    }
  }

  void delete() {
    context.read<NotificationsCubit>().delete(widget.id).then((either) {
      either.fold(
        (failure) => log('Error al eliminar la notificación: $failure'),
        (success) {
          log('Notificación eliminada correctamente');
          context.pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la notificación'),
        actions: [
          IconButton(
            onPressed: delete,
            icon: Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(12.h),
            Text(widget.not['title']).medium,
            Text(formatDate(widget.not['createdAt'], true).toString()),
            Text(widget.not['body']),
          ],
        ),
      ).paddingSymmetric(horizontal: 12.w),
    );
  }
}
