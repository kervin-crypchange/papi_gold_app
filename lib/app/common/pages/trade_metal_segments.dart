import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
String selectedMiniChartTimeFrame = '1D';

class TradeMetalSegments extends StatefulWidget {
  const TradeMetalSegments({super.key});

  @override
  State<TradeMetalSegments> createState() => _TradeMetalSegmentsState();
}

class _TradeMetalSegmentsState extends State<TradeMetalSegments> {
  MetalType metalView = .gold;
  List<Map<String, dynamic>> metalViewList = [
    {'type': MetalType.gold, 'label': Text('Oro')},
    {'type': MetalType.silver, 'label': Text('Plata')},
    {'type': MetalType.platinum, 'label': Text('Platino')},
    {'type': MetalType.palladium, 'label': Text('Paladio')},
  ];

  @override
  Widget build(BuildContext context) {
    return _segmented();
  }

  Widget _segmented() {
    return Column(
      children: [
        SegmentedButton(
          showSelectedIcon: false,
          expandedInsets: EdgeInsets.zero,
          segments: metalViewList
              .map((e) => ButtonSegment(value: e['type'], label: e['label']))
              .toList(),
          selected: {metalView},
          onSelectionChanged: (newSelection) {
            setState(() {
              metalView = newSelection.first;
            });
          },
        ),
        Gap(12.h),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                selectedMiniChartTimeFrame,
                style: context.bodyMedium.copyWith(color: AppColors.white),
              ).overflowText(TextOverflow.ellipsis).medium,
              Icon(Icons.arrow_drop_down, color: AppColors.white),
            ],
          ),
          onTap: () => showMiniChartFilter(),
        ),
        Gap(6.h),
        TradeViewMiniChartWidget(
          key: UniqueKey(),
          timeFrame: selectedMiniChartTimeFrame,
          symbol: symbols[metalView] ?? 'XAUUSD',
        ),
      ],
    ).paddingSymmetric(horizontal: 4.w);
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
    if (res != null) {
      setState(() {
        selectedMiniChartTimeFrame = miniChartFilter[res];
      });
    }
  }
}
