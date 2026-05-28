import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';

class MediButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;

  const MediButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColors.primary,
        elevation: 0,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(borderRadius: DesignSystem.borderM),
        side: isPrimary ? BorderSide.none : const BorderSide(color: AppColors.primary),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20.sp),
                  SizedBox(width: 8.w),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}

class MediTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const MediTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: DesignSystem.borderM,
        boxShadow: DesignSystem.softShadow,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primary, size: 20.sp) : null,
          border: OutlineInputBorder(
            borderRadius: DesignSystem.borderM,
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
      ),
    );
  }
}

class MediCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const MediCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(DesignSystem.spaceM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: DesignSystem.borderL,
          boxShadow: DesignSystem.softShadow,
        ),
        child: child,
      ),
    );
  }
}
