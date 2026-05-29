import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'App Preferences', [
              _buildSettingTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch.adaptive(
                  value: isDark,
                  onChanged: (v) {},
                  activeColor: AppColors.primary,
                ),
              ),
              _buildSettingTile(
                icon: Icons.notifications_active_outlined,
                title: 'Notifications',
                trailing: Switch.adaptive(
                  value: true,
                  onChanged: (v) {},
                  activeColor: AppColors.primary,
                ),
              ),
              _buildSettingTile(
                icon: Icons.language_rounded,
                title: 'Language',
                trailing: Text('English', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 14.sp)),
              ),
            ]),
            SizedBox(height: AppSpacing.s32),
            _buildSection(context, 'Account', [
              _buildSettingTile(icon: Icons.person_outline_rounded, title: 'Personal Info'),
              _buildSettingTile(icon: Icons.security_rounded, title: 'Security'),
              _buildSettingTile(icon: Icons.help_center_outlined, title: 'Help Center'),
              _buildSettingTile(icon: Icons.info_outline_rounded, title: 'About MediConnect', isLast: true),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: AppColors.textSecondaryLight),
          ),
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

  Widget _buildSettingTile({required IconData icon, required String title, Widget? trailing, bool isLast = false}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondaryLight.withOpacity(0.5)),
      shape: !isLast ? Border(bottom: BorderSide(color: AppColors.textSecondaryLight.withOpacity(0.1))) : null,
    );
  }
}
