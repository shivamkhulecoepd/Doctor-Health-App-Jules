import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';

class MessageThreadScreen extends StatelessWidget {
  final String id;
  const MessageThreadScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Dr. Marcus Horizon', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            Text('Cardiologist', style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondaryLight)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppSpacing.s24),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildChatBubble(context, "Hello Sarah, how are you feeling today?", false, isDark),
                _buildChatBubble(context, "I'm feeling much better, thank you doctor!", true, isDark),
                _buildChatBubble(context, "Great to hear. Have you been taking the medicine as prescribed?", false, isDark),
              ],
            ),
          ),
          _buildInputArea(context, isDark),
        ],
      ),
    );
  }

  Widget _buildChatBubble(BuildContext context, String text, bool isMe, bool isDark) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : (isDark ? AppColors.cardDark : Colors.white),
          borderRadius: BorderRadius.circular(16.r).copyWith(
            bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
          ),
          border: isMe ? null : Border.all(color: AppColors.textSecondaryLight.withOpacity(0.1)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black),
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : const Color(0xFFF0F0F5),
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
