import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionManagementScreen extends StatelessWidget {
  const PrescriptionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Prescriptions', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(24.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildPrescriptionCard(context);
        },
      ),
    );
  }

  Widget _buildPrescriptionCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MediCard(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Amoxicillin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorScheme.onSurface)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(color: colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                child: Text('Active', style: TextStyle(color: colorScheme.secondary, fontWeight: FontWeight.bold, fontSize: 12.sp)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text('500mg • 2 times a day', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp)),
          Divider(height: 32.h, color: colorScheme.outlineVariant),
          Row(
            children: [
              Icon(Icons.person_outline_rounded, size: 16.sp, color: colorScheme.onSurfaceVariant),
              SizedBox(width: 8.w),
              Text('Dr. Marcus Horizon', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp)),
              const Spacer(),
              Icon(Icons.event_note_rounded, size: 16.sp, color: colorScheme.onSurfaceVariant),
              SizedBox(width: 8.w),
              Text('Ends in 5 days', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp)),
            ],
          ),
          SizedBox(height: 20.h),
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
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: DesignSystem.borderM,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.qr_code_scanner_rounded, color: colorScheme.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
