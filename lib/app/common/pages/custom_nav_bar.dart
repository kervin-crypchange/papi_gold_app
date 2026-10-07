import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(BuildContext context) {
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Theme.of(context).colorScheme.onSurface;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemes.themeModeNotifier,
      builder: (context, _, _) {
        return Container(
          height: 50.h,
          width: .9.sw,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
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
                    height: 40.h,
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      border: (isSelected && !isDark)
                          ? Border.all(color: selectedColor)
                          : null,
                      color: isSelected
                          ? AppColors.secondary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected
                              ? navItems[index]['iconSelected']
                              : navItems[index]['icon'],
                          color: isSelected
                              ? selectedColor
                              : unselectedColor,
                          size: 16.r,
                        ),
                        Gap(4),
                        Text(
                          navItems[index]['label'],
                          style: context.labelXSmall.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.normal,
                            color: isSelected
                                ? selectedColor
                                : unselectedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ).paddingSymmetric(horizontal: 4.w),
        ).paddingOnly(bottom: navigationBarHeight + 6);
      },
    );
  }
}
