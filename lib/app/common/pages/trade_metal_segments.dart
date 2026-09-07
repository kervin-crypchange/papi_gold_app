import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

enum MetalType { gold, silver, platinum, palladium }

Map<MetalType, String> symbols = {
  MetalType.gold: 'XAUUSD',
  MetalType.silver: 'XAGUSD',
  MetalType.platinum: 'XPTUSD',
  MetalType.palladium: 'XPDUSD',
};

List<String> miniChartFilter = ['1D', '1W', '1M', '3M', '6M', '12M'];
String minichartTimeFrame = '1D';

class TradeMetalSegments extends StatefulWidget {
  const TradeMetalSegments({super.key});

  @override
  State<TradeMetalSegments> createState() => _TradeMetalSegmentsState();
}

class _TradeMetalSegmentsState extends State<TradeMetalSegments> {
  MetalType metalView = .gold;
  @override
  Widget build(BuildContext context) {
    return _segmented().paddingSymmetric(horizontal: 4.w);
  }

  Column _segmented() {
    return Column(
      children: [
        SegmentedButton(
          showSelectedIcon: false,
          expandedInsets: EdgeInsets.zero,
          segments: [
            ButtonSegment(value: MetalType.gold, label: Text('Oro')),
            ButtonSegment(value: MetalType.silver, label: Text('Plata')),
            ButtonSegment(value: MetalType.platinum, label: Text('Platino')),
            ButtonSegment(value: MetalType.palladium, label: Text('Paladio')),
          ],
          selected: {metalView},
          onSelectionChanged: (newSelection) {
            setState(() {
              metalView = newSelection.first;
            });
          },
        ),
        SizedBox(height: 12.h),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                minichartTimeFrame,
                style: context.bodySmall.copyWith(color: AppColors.white),
              ).overflowText(TextOverflow.ellipsis),
              Icon(Icons.arrow_drop_down, color: AppColors.white),
            ],
          ),
          onTap: () => showMiniChartFilter(),
        ),
        TradeViewMiniChartWidget(
          key: UniqueKey(),
          timeFrame: minichartTimeFrame,
          symbol: symbols[metalView] ?? 'XAUUSD',
        ),
      ],
    );
  }

  Future<void> showMiniChartFilter() async {
    final res = await showConfirmationDialog(
      context: context,
      title: 'Filter',
      actions: List.generate(
        miniChartFilter.length,
        (index) => AlertDialogAction(key: index, label: miniChartFilter[index]),
      ),
    );
    setState(() {
      minichartTimeFrame = miniChartFilter[res!];
    });
  }
}
