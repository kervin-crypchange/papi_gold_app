import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<Map<String, dynamic>> navItems;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.navItems,
    required this.onTap,
  });

  Color get bgColor {
    return isDarkTheme ? AppColors.black : AppColors.white;
  }

  Color get unSelectColor {
    return isDarkTheme ? AppColors.white : AppColors.black;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemes.themeModeNotifier,
      builder: (context, _, _) {
        return Container(
          height: 45.h,
          width: .85.sw,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
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
                      border: (isSelected && !isDarkTheme)
                          ? Border.all(color: AppColors.secondary)
                          : null,
                      color: isSelected
                          ? AppColors.secondary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected
                              ? navItems[index]['iconSelected']
                              : navItems[index]['icon'],
                          color: isSelected
                              ? AppColors.secondary
                              : unSelectColor,
                          size: 18,
                        ),
                        Text(
                          navItems[index]['label'],
                          style: context.labelXSmall.copyWith(
                            color: isSelected
                                ? AppColors.secondary
                                : unSelectColor,
                          ),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 4.h),
                ),
              );
            }),
          ).paddingSymmetric(horizontal: 6.w),
        ).paddingOnly(bottom: 32);
      },
    );
  }
}
