import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Profile', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Padding(
                key: ValueKey(_currentStep),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildStepContent(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: MediButton(
                        onPressed: () => setState(() => _currentStep--),
                        text: 'Back',
                        isPrimary: false,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: MediButton(
                    onPressed: () {
                      if (_currentStep < 2) {
                        setState(() => _currentStep++);
                      } else {
                        context.go('/home');
                      }
                    },
                    text: _currentStep == 2 ? 'Complete Setup' : 'Next Step',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final colorScheme = Theme.of(context).colorScheme;
    final titles = ['Info', 'Health', 'Prefs'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = _currentStep >= index;
          return Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: isActive ? colorScheme.primary : colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: isActive ? DesignSystem.softShadow : null,
                      border: Border.all(color: isActive ? colorScheme.primary : colorScheme.outlineVariant, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isActive ? Colors.white : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(titles[index], style: TextStyle(color: isActive ? colorScheme.onSurface : colorScheme.onSurfaceVariant, fontSize: 11.sp, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
                ],
              ),
              if (index < 2)
                Container(
                  width: 40.w,
                  height: 2.h,
                  margin: EdgeInsets.only(bottom: 20.h, left: 8.w, right: 8.w),
                  color: _currentStep > index ? colorScheme.primary : colorScheme.outlineVariant,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    final colorScheme = Theme.of(context).colorScheme;
    switch (_currentStep) {
      case 0:
        return Column(
          children: [
            SizedBox(height: 20.h),
            Stack(
              children: [
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_rounded, size: 60.sp, color: colorScheme.primary),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
                    child: Icon(Icons.add_a_photo_rounded, color: Colors.white, size: 18.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            const MediTextField(hintText: 'Full Name', prefixIcon: Icons.badge_outlined),
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Date of Birth', prefixIcon: Icons.calendar_today_outlined),
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Gender', prefixIcon: Icons.people_outline_rounded),
          ],
        );
      case 1:
        return Column(
          children: [
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Weight (kg)', prefixIcon: Icons.monitor_weight_outlined),
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Height (cm)', prefixIcon: Icons.height_rounded),
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Blood Type', prefixIcon: Icons.bloodtype_outlined),
            SizedBox(height: 20.h),
            const MediTextField(hintText: 'Allergies', prefixIcon: Icons.warning_amber_rounded),
          ],
        );
      case 2:
        return Column(
          children: [
            SizedBox(height: 20.h),
            GlassCard(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Icon(Icons.verified_user_rounded, size: 64.sp, color: colorScheme.primary),
                  SizedBox(height: 24.h),
                  Text(
                    'Privacy & Updates',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Manage how we communicate with you and handle your health data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp, height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: Text('Push Notifications', style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600)),
              subtitle: Text('Reminders for appointments and meds', style: TextStyle(fontSize: 12.sp)),
              activeColor: colorScheme.primary,
            ),
            Divider(height: 1, indent: 16.w, endIndent: 16.w),
            SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: Text('Health Data Sync', style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600)),
              subtitle: Text('Sync with Apple Health / Google Fit', style: TextStyle(fontSize: 12.sp)),
              activeColor: colorScheme.primary,
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
