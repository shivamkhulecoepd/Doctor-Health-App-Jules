import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/models/app_models.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  final VoidCallback onTap;

  const MessageTile({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeStr = DateFormat('hh:mm a').format(message.timestamp);

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      leading: CircleAvatar(
        radius: 28.r,
        backgroundImage: NetworkImage(message.senderImageUrl),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message.senderName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
          ),
          Text(
            timeStr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: message.unreadCount > 0 ? (isDark ? Colors.white : Colors.black) : null,
                fontWeight: message.unreadCount > 0 ? FontWeight.w600 : null,
              ),
            ),
          ),
          if (message.unreadCount > 0)
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${message.unreadCount}',
                style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
