import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/shared/widgets/doctor_card.dart';
import 'package:mediconnect/shared/widgets/appointment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = MockDataService.currentUser;
    final doctors = MockDataService.doctors;
    final appointments = MockDataService.appointments;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context, user, isDark),
            Padding(
              padding: EdgeInsets.all(AppSpacing.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSearchBar(hintText: 'Search doctor or clinic...'),
                  SizedBox(height: AppSpacing.s24),
                  _buildQuickActions(),
                  SizedBox(height: AppSpacing.s32),
                  SectionHeader(
                    title: 'Doctor of the Week',
                    onSeeMore: () => context.push('/doctors'),
                  ),
                  SizedBox(height: AppSpacing.s16),
                  _buildDoctorsList(doctors, context),
                  SizedBox(height: AppSpacing.s32),
                  SectionHeader(
                    title: 'Consultation History',
                    onSeeMore: () => context.push('/appointments'),
                  ),
                  SizedBox(height: AppSpacing.s16),
                  _buildConsultationHistory(appointments, context),
                  SizedBox(height: 100.h), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, user, bool isDark) {
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
              Text(
                'Hi, ${user.name.split(' ')[0]}!',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 8.h),
              Text(
                'How do you feel today?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
          ActionIcon(
            icon: Icons.notifications_none_rounded,
            color: Colors.white,
            onTap: () => context.push('/notifications'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuickActionTile(icon: Icons.video_call_rounded, label: 'Consultation', onTap: () {}, inverted: true),
        QuickActionTile(icon: Icons.local_hospital_rounded, label: 'Hospital', onTap: () {}, inverted: true),
        QuickActionTile(icon: Icons.calendar_month_rounded, label: 'Appointment', onTap: () {}, inverted: true),
        QuickActionTile(icon: Icons.receipt_long_rounded, label: 'Recipe', onTap: () {}, inverted: true),
      ],
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
