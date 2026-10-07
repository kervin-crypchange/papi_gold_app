import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';
import 'package:papi_gold/domain/entities/index.dart';

class CourierTracking extends StatelessWidget {
  final List<TrackingHistoryEntity> history;
  final String status;

  const CourierTracking({
    super.key,
    required this.history,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: ListTile(
              title: Text(status.capitalizeFirst, style: context.bodySmall),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              for (var i = 0; i < history.length; i++)
                _StepRow(step: history[i], isLast: i == history.length - 1),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  final TrackingHistoryEntity step;
  final bool isLast;

  const _StepRow({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.success;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(Icons.check, size: 12.r, color: AppColors.white),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: color)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.status.capitalizeFirst, style: context.bodySmall),
                  Text(
                    step.date,
                    style: context.labelXSmall.copyWith(
                      color: context.accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
