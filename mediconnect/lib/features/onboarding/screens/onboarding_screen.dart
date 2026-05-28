import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _data = [
    OnboardingData(
      title: 'Expert Doctors',
      description: 'Consult with top-tier medical specialists from the comfort of your home.',
      icon: Icons.medical_services_rounded,
    ),
    OnboardingData(
      title: 'Instant Booking',
      description: 'Schedule appointments in seconds with real-time availability tracking.',
      icon: Icons.event_available_rounded,
    ),
    OnboardingData(
      title: 'Health Tracking',
      description: 'Monitor your vitals and health progress with advanced AI analytics.',
      icon: Icons.analytics_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: TextButton(
                  onPressed: () => context.go('/auth'),
                  child: Text('Skip', style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp)),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInDown(
                          child: Container(
                            height: 280.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.05),
                              borderRadius: DesignSystem.borderL,
                            ),
                            child: Icon(
                              _data[index].icon,
                              size: 140.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 48.h),
                        FadeInUp(
                          child: Text(
                            _data[index].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            _data[index].description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _data.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: _currentIndex == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? AppColors.primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  MediButton(
                    text: _currentIndex == _data.length - 1 ? 'Get Started' : 'Continue',
                    onPressed: () {
                      if (_currentIndex == _data.length - 1) {
                        context.go('/auth');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({required this.title, required this.description, required this.icon});
}
