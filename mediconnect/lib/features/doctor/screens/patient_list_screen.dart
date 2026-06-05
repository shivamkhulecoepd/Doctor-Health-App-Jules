import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('My Patients')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.s24),
            child: const AppSearchBar(hintText: 'Search patients...'),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildPatientCard(index, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(int index, bool isDark) {
    final names = ['Sarah Adams', 'John Doe', 'Emily Watson', 'James Bond', 'Emma Stone'];
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
          CircleAvatar(radius: 28.r, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=p$index')),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Last visit: Oct 12, 2023', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12.sp)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondaryLight),
        ],
      ),
    );
  }
}
