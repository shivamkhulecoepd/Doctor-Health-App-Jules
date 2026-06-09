import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedRole = 0; // 0 for Patient, 1 for Doctor
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.s24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(height: 8.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Start your health journey today',
                  style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 32.h),
              _buildRoleSelector(),
              SizedBox(height: 32.h),
              _buildRegisterForm(),
              SizedBox(height: 24.h),
              _buildTermsCheckbox(),
              SizedBox(height: 32.h),
              PrimaryButton(
                text: 'Sign Up',
                onPressed: () => _showOTPDialog(context),
              ),
              SizedBox(height: 40.h),
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

  Widget _buildRegisterForm() {
    return Column(
      children: [
        const AppSearchBar(hintText: 'Full Name'),
        SizedBox(height: 16.h),
        const AppSearchBar(hintText: 'Email'),
        SizedBox(height: 16.h),
        const AppSearchBar(hintText: 'Phone Number'),
        SizedBox(height: 16.h),
        if (_selectedRole == 1) ...[
          const AppSearchBar(hintText: 'Specialization'),
          SizedBox(height: 16.h),
          const AppSearchBar(hintText: 'Medical License Number'),
          SizedBox(height: 16.h),
        ],
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

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (v) => setState(() => _agreeToTerms = v ?? false),
          activeColor: AppColors.primary,
        ),
        Expanded(
          child: Text(
            'I agree to the Terms and Privacy Policy',
            style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondaryLight),
          ),
        ),
      ],
    );
  }

  void _showOTPDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Verify Email', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the 6-digit code sent to your email'),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _OTPBox()),
            ),
            SizedBox(height: 24.h),
            PrimaryButton(text: 'Verify', onPressed: () => context.go('/home')),
          ],
        ),
      ),
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

class _OTPBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.textSecondaryLight.withOpacity(0.2)),
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
