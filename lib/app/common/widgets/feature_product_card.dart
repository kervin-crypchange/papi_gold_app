import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class FeatureProductCard extends StatelessWidget with LoggerMixin {
  FeatureProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.topRight,
      children: [
        Container(
          height: 220.h,
          width: 250.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.r),
                        topRight: Radius.circular(6.r),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/gold_bars.webp',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lingote de Oro',
                    style: context.titleSmall.copyWith(color: AppColors.black),
                  ).medium,
                  Text(
                    'Barras de oro de 1oz, 999.9 Oro Puro',
                    style: context.labelSmall.copyWith(color: AppColors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio',
                            style: context.labelSmall.copyWith(
                              color: AppColors.black,
                            ),
                          ).medium,
                          Text(
                            '\$4,319.10',
                            style: context.labelMedium.copyWith(
                              color: AppColors.secondary,
                            ),
                          ).medium,
                        ],
                      ),
                      Wrap(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              color: AppColors.bg,
                            ),
                            onPressed: () {
                              log('Volume increased');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined),
                            onPressed: () {
                              log('Volume increased');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingAll(8.r),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.black87,
          ),
          child: Text(
            'LINGOTE',
            style: context.bodyXSmall,
          ).paddingSymmetric(vertical: 2.h, horizontal: 8.w).medium,
        ).paddingAll(8.r),
      ],
    );
  }
}
