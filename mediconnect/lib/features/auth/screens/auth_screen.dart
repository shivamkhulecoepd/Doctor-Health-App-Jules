import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthGatewayScreen extends StatelessWidget {
  const AuthGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Decorative background elements
          Positioned(
            top: -100.h,
            right: -100.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  FadeInDown(
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.7)]),
                        borderRadius: DesignSystem.borderM,
                        boxShadow: DesignSystem.softShadow,
                      ),
                      child: Icon(Icons.medical_services_rounded, size: 28.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Welcome to\nMediConnect',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        height: 1.1,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Your health journey starts here. Sign in to access personalized care.',
                      style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16.sp, height: 1.5),
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
                        Expanded(child: Divider(color: colorScheme.outlineVariant.withOpacity(0.5))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: colorScheme.outlineVariant.withOpacity(0.5))),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Row(
                      children: [
                        Expanded(
                          child: _SocialButtonWidgetWidget(icon: FontAwesomeIcons.google, label: 'Google', onTap: () {}),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _SocialButtonWidgetWidget(icon: FontAwesomeIcons.apple, label: 'Apple', onTap: () {}),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButtonWidgetWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButtonWidgetWidget({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GlassCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      borderRadius: DesignSystem.borderM,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
          borderRadius: DesignSystem.borderM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: colorScheme.onSurface),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

