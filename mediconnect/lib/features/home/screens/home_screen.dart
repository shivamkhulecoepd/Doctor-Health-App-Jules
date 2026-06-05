import 'package:intl/intl.dart';
import "package:mediconnect/core/widgets/glass_card.dart";
import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/shared/widgets/doctor_card.dart';
import 'package:mediconnect/shared/widgets/appointment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mediconnect/core/providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(userProvider);
    final doctors = ref.watch(doctorsProvider);
    final appointments = ref.watch(appointmentsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, user),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUpcomingAppointment(context, appointments.firstOrNull),
                  SizedBox(height: AppSpacing.s32),
                  Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: AppSpacing.s16),
                  _buildQuickActionsGrid(context),
                  SizedBox(height: AppSpacing.s32),
                  SectionHeader(
                    title: 'Health Vitals',
                    onSeeMore: () => context.push('/health'),
                  ),
                  SizedBox(height: AppSpacing.s16),
                  _buildVitalsSnapshot(context),
                  SizedBox(height: AppSpacing.s32),
                  SectionHeader(
                    title: 'Top Specialists',
                    onSeeMore: () => context.push('/doctors'),
                  ),
                  SizedBox(height: AppSpacing.s16),
                  _buildDoctorsList(doctors, context),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, user) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.s24, 60.h, AppSpacing.s24, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.push('/profile'),
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=sarah'),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning,',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    user.name.split(' ')[0],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          ActionIcon(
            icon: Icons.notifications_none_rounded,
            onTap: () => context.push('/notifications'),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointment(BuildContext context, dynamic appointment) {
    if (appointment == null) return const SizedBox.shrink();
    return GlassCard(
      padding: EdgeInsets.all(20.r),
      color: Theme.of(context).colorScheme.primary,
      opacity: 0.1,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(appointment.doctorImageUrl),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      appointment.specialty,
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Text('Video Call', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 8.w),
                    const Text('Today', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 8.w),
                    Text(appointment.dateTime, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    final actions = [
      {'icon': Icons.calendar_month_rounded, 'label': 'Book Appointment', 'route': '/doctors'},
      {'icon': Icons.search_rounded, 'label': 'Find Doctor', 'route': '/doctors'},
      {'icon': Icons.biotech_rounded, 'label': 'Lab Results', 'route': '/medical-records'},
      {'icon': Icons.medication_rounded, 'label': 'Prescriptions', 'route': '/prescriptions'},
      {'icon': Icons.emergency_rounded, 'label': 'Emergency', 'route': '/sos'},
      {'icon': Icons.lightbulb_rounded, 'label': 'Health Tips', 'route': '/ai-chat'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 0.9,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return QuickActionTile(
          icon: actions[index]['icon'] as IconData,
          label: actions[index]['label'] as String,
          onTap: () => context.push(actions[index]['route'] as String),
          inverted: true,
        );
      },
    );
  }

  Widget _buildVitalsSnapshot(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildVitalMiniCard(context, 'Heart Rate', '72 bpm', Icons.favorite_rounded, Colors.red),
          _buildVitalMiniCard(context, 'Blood Pressure', '120/80', Icons.speed_rounded, Colors.blue),
          _buildVitalMiniCard(context, 'Sleep', '8h 20m', Icons.bedtime_rounded, Colors.indigo),
          _buildVitalMiniCard(context, 'Steps', '6,432', Icons.directions_walk_rounded, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildVitalMiniCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 12.h),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(doctors, BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(
            doctor: doctors[index],
            onTap: () => context.push('/doctor/${doctors[index].id}'),
            onBookTap: () => context.push('/booking/${doctors[index].id}'),
          );
        },
      ),
    );
  }

  Widget _buildConsultationHistory(appointments, BuildContext context) {
    return Column(
      children: appointments.map<Widget>((appointment) {
        return AppointmentCard(
          appointment: appointment,
          onTap: () => context.push('/appointment/${appointment.id}'),
        );
      }).toList(),
    );
  }
}
