import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/core/providers/app_providers.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/shared/widgets/badges_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DoctorDashboardScreen extends ConsumerWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appointments = ref.watch(appointmentsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildWelcomeHeader(context, isDark),
            Padding(
              padding: EdgeInsets.all(AppSpacing.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsGrid(),
                  SizedBox(height: AppSpacing.s32),
                  const SectionHeader(title: 'Today\'s Schedule'),
                  SizedBox(height: AppSpacing.s16),
                  _buildScheduleTimeline(appointments, isDark),
                  SizedBox(height: AppSpacing.s32),
                  _buildEarningsCard(isDark),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(AppSpacing.s24, 60.h, AppSpacing.s24, 40.h),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient(isDark),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning,', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16.sp)),
              Text('Dr. Marcus!', style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          ActionIcon(icon: Icons.notifications_none_rounded, color: Colors.white, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Appointments', '12', Icons.calendar_today_rounded),
        _buildStatCard('Patients', '45', Icons.people_rounded),
        _buildStatCard('Rating', '4.9', Icons.star_rounded),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          SizedBox(height: 8.h),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondaryLight)),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeline(appointments, bool isDark) {
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Text('09:${index}0 AM', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              SizedBox(width: 16.w),
              Container(width: 2, height: 40, color: AppColors.primary.withOpacity(0.2)),
              SizedBox(width: 16.w),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sarah Adams', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Video Consultation', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  ],
                ),
              ),
              const StatusBadge(label: 'Confirmed', color: AppColors.success),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEarningsCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Earnings this week', style: TextStyle(color: AppColors.textSecondaryLight)),
              Text('\$1,240.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textSecondaryLight, size: 16),
        ],
      ),
    );
  }
}
