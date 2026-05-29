import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String id;
  const AppointmentDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final appointment = MockDataService.appointments.firstWhere((a) => a.id == id, orElse: () => MockDataService.appointments[0]);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Appointment Detail')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorSection(appointment, isDark),
            SizedBox(height: AppSpacing.s32),
            _buildInfoSection('Date & Time', [
              _buildInfoRow(Icons.calendar_today_rounded, DateFormat('EEEE, MMM dd, yyyy').format(appointment.dateTime)),
              SizedBox(height: 12.h),
              _buildInfoRow(Icons.access_time_rounded, DateFormat('hh:mm a').format(appointment.dateTime)),
            ]),
            SizedBox(height: AppSpacing.s32),
            _buildInfoSection('Location', [
              _buildInfoRow(Icons.location_on_rounded, 'San Jose Hospital, Building A, Room 302'),
            ]),
            SizedBox(height: AppSpacing.s32),
            Text('Notes', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            Text(
              'Please bring your latest blood test results and any medications you are currently taking.',
              style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp, height: 1.5),
            ),
            SizedBox(height: 60.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reschedule'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Cancel',
                    onPressed: () {},
                    fullWidth: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorSection(appointment, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 32.r, backgroundImage: NetworkImage(appointment.doctorImageUrl)),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appointment.doctorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              Text(appointment.doctorSpecialty, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 16.h),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        SizedBox(width: 12.w),
        Text(text, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
