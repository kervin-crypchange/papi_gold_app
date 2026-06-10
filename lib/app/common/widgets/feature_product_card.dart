import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class FeatureProductCard extends StatelessWidget {
  const FeatureProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 250.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.r),
                    topRight: Radius.circular(6.r),
                  ),
                ),
                child: Image.asset(
                  'assets/images/gold_bars.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lingote de Oro',
                style: context.titleSmall.copyWith(color: AppColors.black),
              ).paddingSymmetric(horizontal: 8.w).medium,
              Text(
                'Barras de oro de 1oz, 999.9 Oro Puro',
                style: context.labelSmall.copyWith(color: AppColors.black),
              ).paddingSymmetric(horizontal: 8.w),
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
                      ),
                      Text(
                        '\$4,319.10',
                        style: context.labelMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
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
                          print('Volume increased');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          print('Volume increased');
                        },
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 8.w),
            ],
          ),
        ],
      ),
    );
  }
}
