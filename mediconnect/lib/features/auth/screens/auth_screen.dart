import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthGatewayScreen extends StatelessWidget {
  const AuthGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeInDown(
              child: const Icon(Icons.security, size: 100, color: AppColors.primary),
            ),
            const SizedBox(height: 40),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10),
            FadeInDown(
              delay: const Duration(milliseconds: 400),
              child: const Text(
                'Use biometrics or enter your phone number to continue',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 60),
            FadeInUp(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone_iphone, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: () => context.go('/profile-setup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Send OTP'),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR', style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5))),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(icon: FontAwesomeIcons.apple, onTap: () {}),
                  const SizedBox(width: 20),
                  _SocialButton(icon: FontAwesomeIcons.google, onTap: () {}),
                  const SizedBox(width: 20),
                  _SocialButton(icon: Icons.fingerprint, onTap: () {}, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _SocialButton({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color ?? AppColors.textPrimary),
      ),
    );
  }
}
