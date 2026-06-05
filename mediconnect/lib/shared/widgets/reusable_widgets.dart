import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/app_colors.dart';

class QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool inverted;

  const QuickActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.inverted = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              gradient: inverted ? AppColors.primaryGradient : null,
              color: !inverted ? (isDark ? AppColors.cardDark : Colors.white) : null,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: isDark ? null : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(icon, color: inverted ? Colors.white : AppColors.primary, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMore;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        if (onSeeMore != null)
          TextButton(
            onPressed: onSeeMore,
            child: Text(
              'See more',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }
}

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const AppSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search, color: AppColors.textSecondaryLight, size: 20.sp),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final double? size;

  const ActionIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: size ?? 24.sp),
      onPressed: onTap,
    );
  }
}
