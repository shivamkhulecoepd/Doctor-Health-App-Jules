import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isCardFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 32.h),
            _buildHealthIDCard(),
            SizedBox(height: 32.h),
            _buildMenuSection('General', [
              _buildMenuItem(Icons.person_outline_rounded, 'Personal Information', () {}),
              _buildMenuItem(Icons.family_restroom_rounded, 'Family Management', () {}),
              _buildMenuItem(Icons.history_rounded, 'Medical History', () {}),
            ]),
            SizedBox(height: 24.h),
            _buildMenuSection('Preferences', [
              _buildMenuItem(Icons.settings_outlined, 'Settings', () => context.push('/settings')),
              _buildMenuItem(Icons.lock_outline_rounded, 'Privacy & Security', () => context.push('/privacy')),
              _buildMenuItem(Icons.help_outline_rounded, 'Help & Support', () => context.push('/support')),
            ]),
            SizedBox(height: 32.h),
            TextButton(
              onPressed: () {},
              child: Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 16.sp)),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2)),
              child: CircleAvatar(radius: 50.r, backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=user')),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text('Sarah Adams', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Text('ID: MC-2023-8942', style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildHealthIDCard() {
    return GestureDetector(
      onTap: () => setState(() => _isCardFlipped = !_isCardFlipped),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          final rotate = Tween(begin: 3.14, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            builder: (context, widget) {
              final isUnder = (ValueKey(_isCardFlipped) != child.key);
              var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              final value = isUnder ? (rotate.value - 3.14) : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: widget,
              );
            },
            child: child,
          );
        },
        child: _isCardFlipped ? _buildCardBack() : _buildCardFront(),
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      key: const ValueKey(false),
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF0055FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: DesignSystem.borderL,
        boxShadow: DesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('HEALTH ID CARD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12.sp)),
              Icon(Icons.medical_services_rounded, color: Colors.white.withOpacity(0.5), size: 24.sp),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SARAH ADAMS', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold, letterSpacing: 1)),
              Text('DOB: 12/05/1995', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BLOOD TYPE: A+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp)),
              Container(padding: EdgeInsets.all(6.r), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)), child: Icon(Icons.qr_code_2_rounded, size: 28.sp, color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      key: const ValueKey(true),
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: DesignSystem.borderL,
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        boxShadow: DesignSystem.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('EMERGENCY CONTACT', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 14.sp)),
          SizedBox(height: 16.h),
          _buildInfoRow('Name', 'John Adams'),
          _buildInfoRow('Rel.', 'Spouse'),
          _buildInfoRow('Phone', '+1 234 567 890'),
          SizedBox(height: 16.h),
          Text('ALLERGIES: Peanuts, Penicillin', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          SizedBox(width: 50.w, child: Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp))),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary, fontSize: 14.sp)),
        ),
        MediCard(
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondary),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: DesignSystem.borderM),
    );
  }
}
