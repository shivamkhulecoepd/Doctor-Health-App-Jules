import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
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
      color: const Color(0xFF0A84FF),
    ),
    OnboardingData(
      title: 'Instant Booking',
      description: 'Schedule appointments in seconds with real-time availability tracking.',
      icon: Icons.event_available_rounded,
      color: const Color(0xFF34C759),
    ),
    OnboardingData(
      title: 'Health Tracking',
      description: 'Monitor your vitals and health progress with advanced AI analytics.',
      icon: Icons.analytics_rounded,
      color: const Color(0xFFFF9500),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _data[_currentIndex].color.withOpacity(0.2),
                  _data[_currentIndex].color.withOpacity(0.05),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    child: TextButton(
                      onPressed: () => context.go('/auth'),
                      child: Text('Skip', style: TextStyle(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentIndex = index),
                    itemCount: _data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 600),
                              child: GlassCard(
                                padding: EdgeInsets.all(40.r),
                                blur: 30,
                                opacity: 0.1,
                                color: _data[index].color,
                                borderRadius: BorderRadius.circular(40.r),
                                child: Icon(
                                  _data[index].icon,
                                  size: 120.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 60.h),
                            FadeInUp(
                              child: Text(
                                _data[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: Text(
                                _data[index].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 16.sp,
                                  height: 1.6,
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
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            height: 6.h,
                            width: _currentIndex == index ? 24.w : 6.w,
                            decoration: BoxDecoration(
                              color: _currentIndex == index ? colorScheme.primary : colorScheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48.h),
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
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({required this.title, required this.description, required this.icon, required this.color});
}
