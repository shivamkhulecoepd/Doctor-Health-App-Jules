import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Clear All', style: TextStyle(color: colorScheme.error, fontSize: 14.sp)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 8,
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isCritical = index == 0;
          return FadeInUp(
            delay: Duration(milliseconds: index * 50),
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: DesignSystem.borderM,
                boxShadow: DesignSystem.softShadow,
                border: isCritical ? Border(left: BorderSide(color: colorScheme.error, width: 4.w)) : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: (isCritical ? colorScheme.error : colorScheme.primary).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCritical ? Icons.warning_amber_rounded : Icons.notifications_none_rounded,
                      color: isCritical ? colorScheme.error : colorScheme.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isCritical ? 'Critical Health Alert' : 'Appointment Reminder',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: colorScheme.onSurface),
                            ),
                            Text('2m ago', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 11.sp)),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          isCritical
                            ? 'Your heart rate exceeded 100bpm while resting. Please contact your doctor.'
                            : 'Your consultation with Dr. Maria Elena starts in 30 minutes.',
                          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
