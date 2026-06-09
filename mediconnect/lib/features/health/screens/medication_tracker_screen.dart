import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicationTrackerScreen extends ConsumerWidget {
  const MedicationTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Medications')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStreakCard(isDark),
            SizedBox(height: AppSpacing.s32),
            _buildSectionHeader('Today\'s Schedule'),
            SizedBox(height: AppSpacing.s16),
            _buildMedList(isDark),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildStreakCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 32),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Daily Streak', style: TextStyle(color: Colors.white70, fontSize: 13)),
                Text('12 Days!', style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold));
  }

  Widget _buildMedList(bool isDark) {
    return Column(
      children: [
        _buildMedItem('Amoxicillin', '500mg • After Breakfast', true, isDark),
        _buildMedItem('Lisinopril', '10mg • After Lunch', false, isDark),
        _buildMedItem('Metformin', '850mg • Before Dinner', false, isDark),
      ],
    );
  }

  Widget _buildMedItem(String name, String dosage, bool isTaken, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
            child: const Icon(Icons.medication_rounded, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(dosage, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13.sp)),
              ],
            ),
          ),
          Checkbox(
            value: isTaken,
            onChanged: (v) {},
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          ),
        ],
      ),
    );
  }
}
