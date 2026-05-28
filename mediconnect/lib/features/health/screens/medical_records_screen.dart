import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryGrid(),
            SizedBox(height: 32.h),
            Text('Recent Uploads', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            _buildRecentList(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add_rounded, color: Colors.white, size: 28.sp),
        elevation: 4,
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      {'name': 'Lab Reports', 'icon': Icons.biotech_rounded, 'color': Colors.blue},
      {'name': 'Prescriptions', 'icon': Icons.description_rounded, 'color': Colors.green},
      {'name': 'Imaging', 'icon': Icons.visibility_rounded, 'color': Colors.orange},
      {'name': 'Vaccines', 'icon': Icons.vaccines_rounded, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.w,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.4,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return MediCard(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [(category['color'] as Color).withOpacity(0.1), (category['color'] as Color).withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: DesignSystem.borderL,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(category['icon'] as IconData, color: category['color'] as Color, size: 32.sp),
                SizedBox(height: 8.h),
                Text(category['name'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentList() {
    return Column(
      children: [
        _buildRecordTile('Blood Test Result', 'Oct 10, 2023', 'PDF', Colors.red),
        _buildRecordTile('Chest X-Ray', 'Oct 05, 2023', 'IMG', Colors.blue),
        _buildRecordTile('Vaccination Card', 'Sep 20, 2023', 'PDF', Colors.green),
      ],
    );
  }

  Widget _buildRecordTile(String title, String date, String type, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: DesignSystem.borderM,
        boxShadow: DesignSystem.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: DesignSystem.borderM),
            child: Icon(Icons.insert_drive_file_rounded, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
                SizedBox(height: 4.h),
                Text(date, style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4.r)),
            child: Text(type, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
