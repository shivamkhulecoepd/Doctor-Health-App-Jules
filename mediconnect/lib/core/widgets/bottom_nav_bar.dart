import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

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
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.person_search_outlined,
            activeIcon: Icons.person_search,
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
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
          color: isSelected ? AppColors.primary : Colors.white70,
          size: 28,
        ),
      ),
    );
  }
}
