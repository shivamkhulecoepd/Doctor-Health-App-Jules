import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedRole = 0; // 0 for Patient, 1 for Doctor
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.s24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildRoleSelector(),
              SizedBox(height: 40.h),
              FadeInDown(
                child: Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(height: 8.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Sign in to your account',
                  style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 48.h),
              _buildLoginForm(),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                text: 'Sign In',
                onPressed: () => context.go('/home'),
              ),
              SizedBox(height: 40.h),
              _buildSocialLogin(),
              SizedBox(height: 40.h),
              Center(
                child: TextButton(
                  onPressed: () => context.push('/register'),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.cardDark : const Color(0xFFF4F6FF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _RoleButton(
            label: 'Patient',
            isSelected: _selectedRole == 0,
            onTap: () => setState(() => _selectedRole = 0),
          ),
          _RoleButton(
            label: 'Doctor',
            isSelected: _selectedRole == 1,
            onTap: () => setState(() => _selectedRole = 1),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        const AppSearchBar(hintText: 'Email'), // Using AppSearchBar as base or creating dedicated Input
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.cardDark : const Color(0xFFF0F0F5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondaryLight),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textSecondaryLight),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.textSecondaryLight.withOpacity(0.2))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('OR CONTINUE WITH', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColors.textSecondaryLight.withOpacity(0.5))),
            ),
            Expanded(child: Divider(color: AppColors.textSecondaryLight.withOpacity(0.2))),
          ],
        ),
        SizedBox(height: 32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialIcon(icon: FontAwesomeIcons.google, onTap: () {}),
            SizedBox(width: 24.w),
            _SocialIcon(icon: FontAwesomeIcons.apple, onTap: () {}),
          ],
        ),
      ],
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.textSecondaryLight.withOpacity(0.2)),
        ),
        child: Icon(icon, size: 24.sp),
      ),
    );
  }
}
