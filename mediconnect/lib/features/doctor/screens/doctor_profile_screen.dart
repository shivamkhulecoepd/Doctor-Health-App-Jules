import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String id;
  const DoctorProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(),
                  SizedBox(height: 24.h),
                  _buildStatsRow(),
                  SizedBox(height: 32.h),
                  Text('About Doctor', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text(
                    'Dr. Maria Elena is a world-renowned psychologist with over 8 years of experience. She specializes in cognitive behavioral therapy and has helped thousands of patients overcome mental health challenges.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, height: 1.6),
                  ),
                  SizedBox(height: 32.h),
                  Text('Availability', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.h),
                  _buildAvailabilityCalendar(),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: DesignSystem.softShadow,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: MediButton(
          text: 'Book Appointment',
          onPressed: () => context.push('/booking/$id'),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://i.pravatar.cc/600?u=$id',
          fit: BoxFit.cover,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.arrow_back_rounded, color: Colors.white)),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.favorite_border_rounded, color: Colors.white)),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }

  Widget _buildHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Maria Elena', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Text('Psychologist • San Jose Hospital', style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: DesignSystem.borderM),
          child: Icon(Icons.chat_bubble_rounded, color: AppColors.primary, size: 24.sp),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('Patients', '1.2k+'),
        _buildStatItem('Experience', '8 yrs'),
        _buildStatItem('Rating', '4.9'),
        _buildStatItem('Reviews', '120'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildAvailabilityCalendar() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final dates = ['12', '13', '14', '15', '16', '17'];

    return SizedBox(
      height: 84.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            width: 64.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: DesignSystem.borderM,
              border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[200]!),
              boxShadow: isSelected ? DesignSystem.softShadow : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(days[index], style: TextStyle(color: isSelected ? Colors.white70 : AppColors.textSecondary, fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Text(dates[index], style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18.sp)),
              ],
            ),
          );
        },
      ),
    );
  }
}
