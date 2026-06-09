import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(child: _buildCategoryGrid(context)),
            SizedBox(height: 32.h),
            FadeInUp(
              child: Text('Recent Uploads', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
            ),
            SizedBox(height: 16.h),
            _buildRecentList(context),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      floatingActionButton: FadeInRight(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: colorScheme.primary,
          elevation: 6,
          child: Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 28.sp),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
        childAspectRatio: 1.3,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final color = category['color'] as Color;
        return GlassCard(
          padding: EdgeInsets.zero,
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(category['icon'] as IconData, color: color, size: 30.sp),
              ),
              SizedBox(height: 12.h),
              Text(category['name'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: colorScheme.onSurface)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentList(BuildContext context) {
    return Column(
      children: [
        _buildRecordTile(context, 'Blood Test Result', 'Oct 10, 2023', 'PDF', Colors.red, 0),
        _buildRecordTile(context, 'Chest X-Ray Scans', 'Oct 05, 2023', 'IMG', Colors.blue, 1),
        _buildRecordTile(context, 'Vaccination Card', 'Sep 20, 2023', 'PDF', Colors.green, 2),
      ],
    );
  }

  Widget _buildRecordTile(BuildContext context, String title, String date, String type, Color color, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      delay: Duration(milliseconds: 300 + (index * 100)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: GlassCard(
          padding: EdgeInsets.all(16.r),
          onTap: () {},
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
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: colorScheme.onSurface)),
                    SizedBox(height: 4.h),
                    Text(date, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12.sp)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest.withOpacity(0.5), borderRadius: BorderRadius.circular(6.r)),
                child: Text(type, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.more_vert_rounded, size: 20.sp, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
