import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings_outlined)),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildProfileHeader(user),
            SizedBox(height: AppSpacing.s32),
            _buildStatsRow(user),
            SizedBox(height: AppSpacing.s32),
            _buildMenu(context, isDark),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(user) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(user.name, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
        Text(user.email, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp)),
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

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text('$value', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.primary)),
        Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondaryLight)),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 24.h, width: 1, color: AppColors.textSecondaryLight.withOpacity(0.2));
  }

  Widget _buildMenu(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildMenuItem(Icons.person_outline_rounded, 'Edit Profile', () {}),
          _buildMenuItem(Icons.payment_rounded, 'Payment', () {}),
          _buildMenuItem(Icons.notifications_none_rounded, 'Notifications', () => context.push('/notifications')),
          _buildMenuItem(Icons.lock_outline_rounded, 'Privacy', () => context.push('/privacy')),
          _buildMenuItem(Icons.help_outline_rounded, 'Help', () => context.push('/support')),
          _buildMenuItem(Icons.logout_rounded, 'Logout', () {}, isLast: true, color: AppColors.error),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLast = false, Color? color}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? AppColors.primary, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: color)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondaryLight.withOpacity(0.5)),
      shape: !isLast ? Border(bottom: BorderSide(color: AppColors.textSecondaryLight.withOpacity(0.1))) : null,
    );
  }
}
