import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/pages/index.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12.h,
            children: [
              MetalsPriceWidget(),
              TradeMetalSegments(),
            ],
          ).paddingSymmetric(horizontal: 4.w, vertical: 8.h),
        ),
      ),
    );
  }
}
