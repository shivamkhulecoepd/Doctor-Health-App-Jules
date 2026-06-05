import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String id;
  const DoctorProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final doctor = MockDataService.doctors.firstWhere((d) => d.id == id, orElse: () => MockDataService.doctors[0]);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(context, doctor),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.s24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderInfo(context, doctor),
                      SizedBox(height: AppSpacing.s24),
                      _buildStatsRow(context, doctor, isDark),
                      SizedBox(height: AppSpacing.s32),
                      Text('About Doctor', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 12.h),
                      Text(
                        doctor.about,
                        style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp, height: 1.6),
                      ),
                      SizedBox(height: AppSpacing.s32),
                      Text('Working Time', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 16.h),
                      _buildWorkingTime(context, isDark),
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildBottomButton(context, doctor),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, doctor) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(doctor.imageUrl, fit: BoxFit.cover),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, doctor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.name, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)),
            Text(doctor.specialty, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp)),
          ],
        ),
        Row(
          children: [
            ActionIcon(icon: Icons.star_rounded, color: Colors.orange, onTap: () {}),
            SizedBox(width: 4.w),
            Text('${doctor.rating}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, doctor, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Experience', '${doctor.experienceYears} yrs', Icons.work_history_rounded, isDark),
        _buildStatCard('Patients', '1.2k+', Icons.people_rounded, isDark),
        _buildStatCard('Reviews', '${doctor.reviews}', Icons.reviews_rounded, isDark),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, bool isDark) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFFF4F6FF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(height: 8.h),
          Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp)),
          Text(label, style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondaryLight)),
        ],
      ),
    );
  }

  Widget _buildWorkingTime(BuildContext context, bool isDark) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded, color: AppColors.primary, size: 20),
        SizedBox(width: 8.w),
        Text('Mon - Fri, 09:00 AM - 05:00 PM', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context, doctor) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: PrimaryButton(
          text: 'Book Appointment',
          onPressed: () => context.push('/booking/${doctor.id}'),
        ),
      ),
    );
  }
}
