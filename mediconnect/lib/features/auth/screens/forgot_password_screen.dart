import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 0; // 0: Email, 1: OTP, 2: New Password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Text(
                  _getTitle(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(height: 8.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  _getSubtitle(),
                  style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 48.h),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStepContent(),
                ),
              ),
              PrimaryButton(
                text: _currentStep == 2 ? 'Reset Password' : 'Continue',
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                  } else {
                    _showSuccessAndRedirect();
                  }
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_currentStep) {
      case 0: return 'Forgot Password';
      case 1: return 'Verify Email';
      case 2: return 'New Password';
      default: return '';
    }
  }

  String _getSubtitle() {
    switch (_currentStep) {
      case 0: return 'Enter your email to receive an OTP';
      case 1: return 'Enter the 6-digit code sent to you';
      case 2: return 'Create a strong new password';
      default: return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return const Column(
          key: ValueKey(0),
          children: [
            AppSearchBar(hintText: 'Email Address'),
          ],
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _OTPBox()),
            ),
            SizedBox(height: 24.h),
            TextButton(
              onPressed: () {},
              child: const Text('Resend OTP in 59s', style: TextStyle(color: AppColors.textSecondaryLight)),
            ),
          ],
        );
      case 2:
        return const Column(
          key: ValueKey(2),
          children: [
            AppSearchBar(hintText: 'New Password'),
            SizedBox(height: 16.h),
            AppSearchBar(hintText: 'Confirm New Password'),
          ],
        );
      default:
        return Container();
    }
  }

  void _showSuccessAndRedirect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset successful!'), backgroundColor: AppColors.success),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.go('/login');
    });
  }
}

class _OTPBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(counterText: '', border: InputBorder.none),
      ),
    );
  }
}
