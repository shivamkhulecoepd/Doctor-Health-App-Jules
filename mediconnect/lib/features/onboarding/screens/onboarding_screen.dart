import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

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
      title: 'Find Doctors',
      description: 'Search from thousands of qualified medical professionals in your area.',
      icon: Icons.search_rounded,
    ),
    OnboardingData(
      title: 'Book Appointments',
      description: 'Easily schedule and manage your medical appointments with a few taps.',
      icon: Icons.calendar_month_rounded,
    ),
    OnboardingData(
      title: 'Track Health',
      description: 'Keep track of your vitals and medical history in one secure place.',
      icon: Icons.monitor_heart_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          _data[index].icon,
                          size: 150,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    FadeInUp(
                      child: Text(
                        _data[index].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        _data[index].description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 60,
            right: 20,
            child: TextButton(
              onPressed: () => context.go('/auth'),
              child: const Text('Skip', style: TextStyle(color: AppColors.textSecondary)),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _data.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? AppColors.primary : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == _data.length - 1) {
                        context.go('/auth');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(_currentIndex == _data.length - 1 ? 'Get Started' : 'Next'),
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

  OnboardingData({required this.title, required this.description, required this.icon});
}
