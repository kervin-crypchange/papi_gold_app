import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

enum MetalType { gold, silver, platinum, palladium }

Map<MetalType, String> symbols = {
  MetalType.gold: 'XAUUSD',
  MetalType.silver: 'XAGUSD',
  MetalType.platinum: 'XPTUSD',
  MetalType.palladium: 'XPDUSD',
};

class TradeMetalSegments extends StatefulWidget {
  const TradeMetalSegments({super.key});

  @override
  State<TradeMetalSegments> createState() => _TradeMetalSegmentsState();
}

class _TradeMetalSegmentsState extends State<TradeMetalSegments> {
  MetalType metalView = .gold;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton(
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
        TradeViewMiniChartWidget(
          key: UniqueKey(),
          symbol: symbols[metalView] ?? 'XAUUSD',
        ),
      ],
    ).paddingSymmetric(horizontal: 4.w);
  }
}
