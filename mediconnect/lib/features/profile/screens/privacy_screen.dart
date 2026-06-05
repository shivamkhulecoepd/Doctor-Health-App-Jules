import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          children: [
            FadeInDown(child: _buildEncryptionInfo(context, isDark)),
            SizedBox(height: AppSpacing.s32),
            _buildGroup(context, 'Authentication', [
              _buildToggleTile('Face ID / Biometric', true),
              _buildToggleTile('Two-Factor Auth', false),
              _buildLinkTile('Change Password'),
            ], isDark),
            SizedBox(height: AppSpacing.s32),
            _buildGroup(context, 'Data & Privacy', [
              _buildToggleTile('Share with Insurance', true),
              _buildToggleTile('Anonymous Analytics', true),
              _buildLinkTile('Export My Data'),
              _buildLinkTile('Delete Account', isLast: true, color: AppColors.error),
            ], isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildEncryptionInfo(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.success.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
            child: const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 24),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('End-to-End Encrypted', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: AppColors.success)),
                SizedBox(height: 4.h),
                Text('Your medical records and chats are fully protected.', style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondaryLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String title, List<Widget> children, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: AppColors.textSecondaryLight)),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildToggleTile(String title, bool value) {
    return SwitchListTile.adaptive(
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
      value: value,
      onChanged: (v) {},
      activeColor: AppColors.primary,
    );
  }

  Widget _buildLinkTile(String title, {bool isLast = false, Color? color}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: color)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondaryLight.withOpacity(0.5)),
      onTap: () {},
      shape: !isLast ? Border(bottom: BorderSide(color: AppColors.textSecondaryLight.withOpacity(0.1))) : null,
    );
  }
}
