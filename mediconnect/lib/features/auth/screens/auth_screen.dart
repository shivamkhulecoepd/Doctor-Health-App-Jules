import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthGatewayScreen extends StatelessWidget {
  const AuthGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              FadeInDown(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: DesignSystem.borderM,
                  ),
                  child: Icon(Icons.shield_rounded, size: 32.sp, color: AppColors.primary),
                ),
              ),
              SizedBox(height: 32.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Welcome to\nMediConnect',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Your health journey starts here. Sign in to continue.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 48.h),
              FadeInUp(
                child: const MediTextField(
                  hintText: 'Phone Number',
                  prefixIcon: Icons.phone_iphone_rounded,
                ),
              ),
              SizedBox(height: 24.h),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: MediButton(
                  text: 'Send Verification Code',
                  onPressed: () => context.go('/profile-setup'),
                ),
              ),
              SizedBox(height: 40.h),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: TextStyle(
                          color: AppColors.textSecondary.withOpacity(0.5),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Row(
                  children: [
                    Expanded(
                      child: _SocialButton(icon: FontAwesomeIcons.google, label: 'Google', onTap: () {}),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _SocialButton(icon: FontAwesomeIcons.apple, label: 'Apple', onTap: () {}),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
                        children: const [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: DesignSystem.borderM,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: DesignSystem.borderM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp),
            SizedBox(width: 12.w),
            Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
