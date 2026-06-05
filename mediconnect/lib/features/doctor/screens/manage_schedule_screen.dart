import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ManageScheduleScreen extends StatefulWidget {
  const ManageScheduleScreen({super.key});

  @override
  State<ManageScheduleScreen> createState() => _ManageScheduleScreenState();
}

class _ManageScheduleScreenState extends State<ManageScheduleScreen> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Schedule')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendarStrip(isDark),
            SizedBox(height: AppSpacing.s32),
            const Text('Availability', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            _buildTimeSetting('Morning', '09:00 AM - 12:00 PM', true, isDark),
            _buildTimeSetting('Afternoon', '01:00 PM - 05:00 PM', true, isDark),
            _buildTimeSetting('Evening', '06:00 PM - 08:00 PM', false, isDark),
            SizedBox(height: 32.h),
            PrimaryButton(text: 'Save Changes', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarStrip(bool isDark) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isSelected = date.day == _focusedDay.day;
          return GestureDetector(
            onTap: () => setState(() => _focusedDay = date),
            child: Container(
              width: 64.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : (isDark ? AppColors.cardDark : const Color(0xFFF4F6FF)),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('E').format(date), style: TextStyle(color: isSelected ? Colors.white70 : AppColors.textSecondaryLight)),
                  Text(DateFormat('dd').format(date), style: TextStyle(color: isSelected ? Colors.white : null, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSetting(String period, String range, bool isActive, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(period, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(range, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12.sp)),
            ],
          ),
          Switch.adaptive(value: isActive, onChanged: (v) {}, activeColor: AppColors.primary),
        ],
      ),
    );
  }
}
