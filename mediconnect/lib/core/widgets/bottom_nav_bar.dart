import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(36.r),
        boxShadow: DesignSystem.premiumShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.grid_view_outlined,
            activeIcon: Icons.grid_view_rounded,
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.person_search_outlined,
            activeIcon: Icons.person_search_rounded,
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today_rounded,
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
            isSelected: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isSelected ? 1.2 : 1.0,
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 26.sp,
        ),
      ),
    );
  }
}
