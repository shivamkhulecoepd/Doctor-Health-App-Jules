import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class PrescriptionManagementScreen extends StatelessWidget {
  const PrescriptionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Prescriptions', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: index * 100),
            child: _buildPrescriptionCard(context, index),
          );
        },
      ),
    );
  }

  Widget _buildPrescriptionCard(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final medications = ['Amoxicillin', 'Lisinopril', 'Metformin', 'Atorvastatin'];
    final dosages = ['500mg • 2 times a day', '10mg • 1 time a day', '850mg • 2 times a day', '20mg • 1 time a day'];
    final doctors = ['Dr. Marcus Horizon', 'Dr. Maria Elena', 'Dr. John Adams', 'Dr. Sarah Smith'];

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GlassCard(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(medications[index % 4], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorScheme.onSurface)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(color: colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                  child: Text('Active', style: TextStyle(color: colorScheme.secondary, fontWeight: FontWeight.bold, fontSize: 12.sp)),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(dosages[index % 4], style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp)),
            Divider(height: 32.h, color: colorScheme.outlineVariant.withOpacity(0.5)),
            Row(
              children: [
                Icon(Icons.person_outline_rounded, size: 16.sp, color: colorScheme.onSurfaceVariant),
                SizedBox(width: 8.w),
                Text(doctors[index % 4], style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp)),
                const Spacer(),
                Icon(Icons.event_note_rounded, size: 16.sp, color: colorScheme.onSurfaceVariant),
                SizedBox(width: 8.w),
                Text('Ends in ${5 + index} days', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp)),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: MediButton(
                    text: 'Request Refill',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 56.h,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: DesignSystem.borderM,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.qr_code_scanner_rounded, color: colorScheme.primary, size: 24.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
