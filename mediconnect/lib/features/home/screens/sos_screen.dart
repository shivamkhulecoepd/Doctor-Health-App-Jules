import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';

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
      duration: const Duration(seconds: 1.5),
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
      if (!mounted || !_isCounting) return;
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    if (_isCounting) {
      // Trigger Emergency Action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF4B2B), Color(0xFFFF416C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              FadeInDown(
                child: Text(
                  'EMERGENCY SOS',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              FadeIn(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Text(
                    'Hold the button for 3 seconds to alert emergency services and shared contacts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16.sp, height: 1.5),
                  ),
                ),
              ),
              const Spacer(),
              _buildPulseButton(),
              const Spacer(),
              FadeInUp(child: _buildEmergencyContacts()),
              SizedBox(height: 60.h),
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
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 280.w * (1 + _pulseController.value * 0.15),
                height: 280.w * (1 + _pulseController.value * 0.15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Container(
                width: 240.w,
                height: 240.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white30, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: 180.w,
                    height: 180.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 30, offset: Offset(0, 10))],
                    ),
                    child: Center(
                      child: _isCounting
                          ? Text(
                              '$_countdown',
                              style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w900, color: const Color(0xFFFF416C)),
                            )
                          : Icon(Icons.emergency_share_rounded, size: 72.sp, color: const Color(0xFFFF416C)),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Column(
      children: [
        Text(
          'EMERGENCY CONTACTS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.sp, letterSpacing: 1.5),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildContactItem('Wife', Icons.favorite_rounded),
              _buildContactItem('Dad', Icons.person_rounded),
              _buildContactItem('Clinic', Icons.local_hospital_rounded),
              _buildContactItem('Ambulance', Icons.emergency_rounded),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(String name, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
