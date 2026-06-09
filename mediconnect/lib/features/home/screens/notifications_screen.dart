import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = MockDataService.notifications;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all as read'),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: EdgeInsets.all(AppSpacing.s24),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(context, notification, isDark);
              },
            ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, notification, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark ? null : [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(notification.type),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      DateFormat('hh:mm a').format(notification.timestamp),
                      style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: TextStyle(fontSize: 13.sp, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String type) {
    IconData iconData;
    Color color;
    switch (type) {
      case 'appointment':
        iconData = Icons.calendar_today_rounded;
        color = AppColors.primary;
        break;
      case 'message':
        iconData = Icons.chat_bubble_outline_rounded;
        color = AppColors.accent;
        break;
      default:
        iconData = Icons.notifications_none_rounded;
        color = AppColors.success;
    }
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(iconData, color: color, size: 20.sp),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64.sp, color: AppColors.textSecondaryLight.withOpacity(0.3)),
          SizedBox(height: 16.h),
          Text(
            'No notifications yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
