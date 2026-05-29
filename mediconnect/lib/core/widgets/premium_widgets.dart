import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colorScheme.primary : colorScheme.surface,
        foregroundColor: isPrimary ? colorScheme.onPrimary : colorScheme.primary,
        elevation: 0,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(borderRadius: DesignSystem.borderM),
        side: isPrimary ? BorderSide.none : BorderSide(color: colorScheme.primary),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: isPrimary ? colorScheme.onPrimary : colorScheme.primary,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: DesignSystem.borderM,
        boxShadow: DesignSystem.softShadow,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: colorScheme.primary, size: 20.sp) : null,
          border: OutlineInputBorder(
            borderRadius: DesignSystem.borderM,
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colorScheme.surface,
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
  final Color? color;

  const MediCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(DesignSystem.spaceM),
        decoration: BoxDecoration(
          color: color ?? colorScheme.surface,
          borderRadius: DesignSystem.borderL,
          boxShadow: DesignSystem.softShadow,
        ),
        child: child,
      ),
    );
  }
}
