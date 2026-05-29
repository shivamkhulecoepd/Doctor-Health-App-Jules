import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/features/profile/providers/user_provider.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  bool _isCardFlipped = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildProfileHeader(user),
            SizedBox(height: 32.h),
            _buildHealthIDCard(user),
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

  Widget _buildProfileHeader(UserProfile user) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: colorScheme.primary, width: 2)),
              child: CircleAvatar(radius: 50.r, backgroundImage: NetworkImage(user.imageUrl)),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
                child: Icon(Icons.camera_alt_rounded, color: colorScheme.onPrimary, size: 16.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(user.name, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        SizedBox(height: 4.h),
        Text('ID: ${user.id}', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildHealthIDCard(UserProfile user) {
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
        child: _isCardFlipped ? _buildCardBack() : _buildCardFront(user),
      ),
    );
  }

  Widget _buildCardFront(UserProfile user) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey(false),
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withBlue(255).withRed(0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
              Text(user.name.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold, letterSpacing: 1)),
              Text('DOB: ${user.dob}', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BLOOD TYPE: ${user.bloodType}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp)),
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(Icons.qr_code_2_rounded, size: 28, color: Color(0xFF1C1C1E)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey(true),
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: DesignSystem.borderL,
        border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
        boxShadow: DesignSystem.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('EMERGENCY CONTACT', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary, fontSize: 14.sp)),
          SizedBox(height: 16.h),
          _buildInfoRow('Name', 'John Adams'),
          _buildInfoRow('Rel.', 'Spouse'),
          _buildInfoRow('Phone', '+1 234 567 890'),
          SizedBox(height: 16.h),
          Text('ALLERGIES: Peanuts, Penicillin', style: TextStyle(color: colorScheme.error, fontWeight: FontWeight.bold, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          SizedBox(width: 50.w, child: Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp))),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: colorScheme.onSurface)),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant, fontSize: 14.sp)),
        ),
        MediCard(
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colorScheme.primary, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: colorScheme.onSurfaceVariant),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: DesignSystem.borderM),
    );
  }
}
