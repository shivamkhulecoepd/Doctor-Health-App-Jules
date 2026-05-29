import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/features/appointments/providers/appointments_provider.dart';
import 'package:mediconnect/features/health/providers/vitals_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentsProvider);
    final upcomingAppointment = appointments.isEmpty ? null : appointments.firstWhere((a) => a.status == 'Confirmed', orElse: () => appointments.first);
    final vitals = ref.watch(vitalsProvider);

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
                  if (upcomingAppointment != null) _buildUpcomingCard(context, upcomingAppointment),
                  SizedBox(height: 32.h),
                  _buildSectionHeader(context, 'Quick Actions', () {}),
                  SizedBox(height: 16.h),
                  _buildQuickActions(context),
                  SizedBox(height: 32.h),
                  _buildSectionHeader(context, 'Your Vitals', () => context.push('/health')),
                  SizedBox(height: 16.h),
                  _buildVitalsGrid(context, vitals),
                  SizedBox(height: 32.h),
                  _buildSectionHeader(context, 'Top Specialists', () => context.push('/doctors')),
                  SizedBox(height: 16.h),
                  _buildSpecialistsList(context),
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
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: 140.h,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16.sp),
                  ),
                  Text(
                    'Sarah Adams',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: DesignSystem.borderM,
                  boxShadow: DesignSystem.softShadow,
                ),
                child: IconButton(
                  onPressed: () => context.push('/notifications'),
                  icon: Badge(
                    label: const Text('2'),
                    backgroundColor: colorScheme.error,
                    child: Icon(Icons.notifications_outlined, color: colorScheme.onSurface),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onSeeAll) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text('See All', style: TextStyle(color: colorScheme.primary, fontSize: 14.sp)),
        ),
      ],
    );
  }

  Widget _buildUpcomingCard(BuildContext context, dynamic appointment) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInRight(
      child: Container(
        padding: EdgeInsets.all(20.r),
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
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: DesignSystem.borderM,
                  ),
                  child: const Icon(Icons.videocam_rounded, color: Colors.white, size: 24),
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
                        appointment.doctorName,
                        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat.jm().format(appointment.dateTime),
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
    final colorScheme = Theme.of(context).colorScheme;
    final actions = [
      {'icon': Icons.calendar_month_rounded, 'label': 'Book', 'color': Colors.blue, 'route': '/doctors'},
      {'icon': Icons.medical_services_rounded, 'label': 'Records', 'color': Colors.green, 'route': '/medical-records'},
      {'icon': Icons.medication_rounded, 'label': 'Meds', 'color': Colors.orange, 'route': '/prescriptions'},
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
                  color: colorScheme.surface,
                  borderRadius: DesignSystem.borderM,
                  boxShadow: DesignSystem.softShadow,
                ),
                child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 28.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                action['label'] as String,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVitalsGrid(BuildContext context, dynamic vitals) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          if (vitals['Heart Rate'] != null)
            _buildVitalCard(context, 'Heart Rate', '${vitals['Heart Rate'].value} bpm', Icons.favorite_rounded, Colors.red),
          if (vitals['Sleep'] != null)
            _buildVitalCard(context, 'Sleep', '${vitals['Sleep'].value}h', Icons.bedtime_rounded, Colors.indigo),
          if (vitals['Steps'] != null)
            _buildVitalCard(context, 'Steps', vitals['Steps'].value, Icons.directions_walk_rounded, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildVitalCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
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
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistsList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: List.generate(2, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colorScheme.surface,
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
                    Text(
                      'Dr. Maria Elena',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: colorScheme.onSurface),
                    ),
                    Text(
                      'Psychologist • ★ 4.9',
                      style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(4.r)),
                      child: Text(
                        'Available Today',
                        style: TextStyle(color: colorScheme.secondary, fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.push('/doctor/$index'),
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        );
      }),
    );
  }
}
