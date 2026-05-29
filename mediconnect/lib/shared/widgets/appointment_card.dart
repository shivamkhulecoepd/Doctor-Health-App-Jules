import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/models/app_models.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'badges_icons.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateStr = DateFormat('MMM dd, yyyy').format(appointment.dateTime);
    final timeStr = DateFormat('hh:mm a').format(appointment.dateTime);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(appointment.doctorImageUrl),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                      ),
                      Text(
                        appointment.doctorSpecialty,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (appointment.documentsCount > 0)
                  StatusBadge(label: '${appointment.documentsCount} Docs', color: AppColors.primary),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _Badge(label: dateStr, color: AppColors.accent),
                SizedBox(width: 8.w),
                _Badge(label: timeStr, color: const Color(0xFF1A1A2E)),
                const Spacer(),
                StatusBadge(
                  label: appointment.status,
                  color: _getStatusColor(appointment.status),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming': return AppColors.primary;
      case 'Completed': return AppColors.success;
      case 'Cancelled': return AppColors.error;
      default: return AppColors.textSecondaryLight;
    }
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
