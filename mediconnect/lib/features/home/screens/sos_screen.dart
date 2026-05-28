import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/design_system.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _countdown = 3;
  bool _isCounting = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startCountdown() async {
    setState(() => _isCounting = true);
    for (int i = 3; i > 0; i--) {
      if (!mounted) return;
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    // Action triggered
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF3B30), Color(0xFF8B0000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(DesignSystem.spaceM),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: Colors.white, size: 30.sp),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'EMERGENCY SOS',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, letterSpacing: 2),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'Press and hold the button for 3 seconds to call emergency services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16.sp),
                ),
              ),
              const Spacer(),
              _buildPulseButton(),
              const Spacer(),
              _buildEmergencyContacts(),
              SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulseButton() {
    return GestureDetector(
      onLongPressStart: (_) => _startCountdown(),
      onLongPressEnd: (_) => setState(() {
        _isCounting = false;
        _countdown = 3;
      }),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Container(
            width: 240.w,
            height: 240.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2 + (20 * _pulseController.value).w,
              ),
            ),
            child: Center(
              child: Container(
                width: 160.w,
                height: 160.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10)),
                  ],
                ),
                child: Center(
                  child: _isCounting
                      ? Text(
                          '$_countdown',
                          style: TextStyle(
                            fontSize: 72.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFFFF3B30),
                          ),
                        )
                      : Icon(
                          Icons.power_settings_new_rounded,
                          size: 80.sp,
                          color: const Color(0xFFFF3B30),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Column(
      children: [
        Text(
          'Quick Contacts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 90.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              _buildContactItem('Wife', Icons.person_rounded),
              _buildContactItem('Dad', Icons.person_rounded),
              _buildContactItem('Clinic', Icons.local_hospital_rounded),
              _buildContactItem('911', Icons.emergency_rounded),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(String name, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white24,
            child: Icon(icon, color: Colors.white, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
