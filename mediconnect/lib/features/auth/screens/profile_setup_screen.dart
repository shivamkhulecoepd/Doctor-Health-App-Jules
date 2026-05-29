import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
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
        title: Text('Profile Setup', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.w),
              child: _buildStepContent(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.w),
            child: MediButton(
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  context.go('/home');
                }
              },
              text: _currentStep == 2 ? 'Finish' : 'Next',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: _currentStep >= index ? colorScheme.primary : colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: _currentStep >= index ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              if (index < 2)
                Container(
                  width: 40.w,
                  height: 2.h,
                  color: _currentStep > index ? colorScheme.primary : colorScheme.surfaceVariant,
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
        return FadeIn(
          child: Column(
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, size: 40.sp, color: colorScheme.primary),
              ),
              SizedBox(height: 40.h),
              const MediTextField(hintText: 'Full Name', prefixIcon: Icons.person_outline),
              SizedBox(height: 20.h),
              const MediTextField(hintText: 'Date of Birth', prefixIcon: Icons.calendar_today_outlined),
              SizedBox(height: 20.h),
              const MediTextField(hintText: 'Gender', prefixIcon: Icons.male_outlined),
            ],
          ),
        );
      case 1:
        return FadeIn(
          child: Column(
            children: [
              const MediTextField(hintText: 'Weight (kg)', prefixIcon: Icons.monitor_weight_outlined),
              SizedBox(height: 20.h),
              const MediTextField(hintText: 'Height (cm)', prefixIcon: Icons.height),
              SizedBox(height: 20.h),
              const MediTextField(hintText: 'Blood Type', prefixIcon: Icons.bloodtype_outlined),
              SizedBox(height: 20.h),
              const MediTextField(hintText: 'Allergies', prefixIcon: Icons.warning_amber_outlined),
            ],
          ),
        );
      case 2:
        return FadeIn(
          child: Column(
            children: [
              Text(
                'Almost there!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 20.h),
              Text(
                'Choose your notification preferences and medical data sharing options.',
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              SizedBox(height: 40.h),
              SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('Push Notifications', style: TextStyle(color: colorScheme.onSurface)),
                activeColor: colorScheme.primary,
              ),
              SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('Health Data Sync', style: TextStyle(color: colorScheme.onSurface)),
                activeColor: colorScheme.primary,
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
