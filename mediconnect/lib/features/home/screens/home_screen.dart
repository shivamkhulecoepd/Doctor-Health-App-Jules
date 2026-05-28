import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUpcomingCard(context),
                  SizedBox(height: 32.h),
                  _buildSectionHeader('Quick Actions', () {}),
                  SizedBox(height: 16.h),
                  _buildQuickActions(context),
                  SizedBox(height: 32.h),
                  _buildSectionHeader('Your Vitals', () {}),
                  SizedBox(height: 16.h),
                  _buildVitalsGrid(),
                  SizedBox(height: 32.h),
                  _buildSectionHeader('Top Specialists', () {}),
                  SizedBox(height: 16.h),
                  _buildSpecialistsList(),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140.h,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.background,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
                  ),
                  Text(
                    'Sarah Adams',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: DesignSystem.borderM,
                  boxShadow: DesignSystem.softShadow,
                ),
                child: IconButton(
                  onPressed: () => context.push('/notifications'),
                  icon: const Badge(
                    label: Text('2'),
                    child: Icon(Icons.notifications_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text('See All', style: TextStyle(color: AppColors.primary, fontSize: 14.sp)),
        ),
      ],
    );
  }

  Widget _buildUpcomingCard(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF0055FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: DesignSystem.borderL,
          boxShadow: DesignSystem.premiumShadow,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: DesignSystem.borderM,
                  ),
                  child: Icon(Icons.videocam_rounded, color: Colors.white, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Consultation',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp),
                      ),
                      Text(
                        'Dr. Marcus Horizon',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  '10:30 AM',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MediButton(
              text: 'Join Consultation',
              onPressed: () => context.push('/video-call'),
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.calendar_month_rounded, 'label': 'Book', 'color': Colors.blue},
      {'icon': Icons.medical_services_rounded, 'label': 'Records', 'color': Colors.green},
      {'icon': Icons.medication_rounded, 'label': 'Meds', 'color': Colors.orange},
      {'icon': Icons.emergency_rounded, 'label': 'SOS', 'color': Colors.red, 'route': '/sos'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return GestureDetector(
          onTap: () {
            if (action['route'] != null) context.push(action['route'] as String);
          },
          child: Column(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: DesignSystem.borderM,
                  boxShadow: DesignSystem.softShadow,
                ),
                child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 28.sp),
              ),
              SizedBox(height: 8.h),
              Text(action['label'] as String, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVitalsGrid() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildVitalCard('Heart Rate', '82 bpm', Icons.favorite_rounded, Colors.red),
          _buildVitalCard('Sleep', '7h 20m', Icons.bedtime_rounded, Colors.indigo),
          _buildVitalCard('Steps', '8,432', Icons.directions_walk_rounded, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: DesignSystem.borderM,
        boxShadow: DesignSystem.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(height: 16.h),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
          Text(title, style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildSpecialistsList() {
    return Column(
      children: List.generate(2, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: DesignSystem.borderM,
            boxShadow: DesignSystem.softShadow,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: DesignSystem.borderM,
                child: Image.network('https://i.pravatar.cc/150?u=doc$index', width: 80.w, height: 80.w, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr. Maria Elena', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    Text('Psychologist • ★ 4.9', style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp)),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(4.r)),
                      child: Text('Available Today', style: TextStyle(color: AppColors.secondary, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16)),
            ],
          ),
        );
      }),
    );
  }
}
