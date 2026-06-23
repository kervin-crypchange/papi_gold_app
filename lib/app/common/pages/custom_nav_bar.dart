import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.shopping_cart_checkout_rounded, 'label': 'Ordenes'},
      {'icon': Icons.person_pin_rounded, 'label': 'Perfil'},
    ];
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      navItems[index]['icon'],
                      color: isSelected
                          ? AppColors.secondary
                          : Colors.grey.shade600,
                      size: 20,
                    ),
                    Text(
                      navItems[index]['label'],
                      style: context.labelXSmall.copyWith(
                        color: isSelected
                            ? AppColors.secondary
                            : Colors.grey.shade600,
                      ),
                    ),
                    // if (isSelected) ...[
                    //   Text(
                    //     navItems[index]['label'],
                    //     style: context.labelXSmall.copyWith(color: AppColors.secondary),
                    //   ),
                    // ],
                  ],
                ),
              ).paddingSymmetric(vertical: 4.h),
            ),
          );
        }),
      ).paddingSymmetric(horizontal: 6.w),
    ).paddingSymmetric(vertical: 24.h, horizontal: 12.w);
  }
}
