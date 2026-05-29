import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/models/app_models.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'badges_icons.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;
  final VoidCallback? onBookTap;
  final VoidCallback? onChatTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    this.onBookTap,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240.w,
        margin: EdgeInsets.only(right: 16.w),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                doctor.imageUrl,
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              doctor.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doctor.specialty,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBookTap,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      minimumSize: Size.zero,
                    ),
                    child: Text('Book', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
                SizedBox(width: 8.w),
                ActionIcon(
                  icon: Icons.chat_bubble_rounded,
                  color: AppColors.accent,
                  onTap: onChatTap ?? () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
