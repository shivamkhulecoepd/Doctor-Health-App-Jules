import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/shared/widgets/message_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = MockDataService.messages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.s24),
            child: Row(
              children: [
                const Expanded(
                  child: AppSearchBar(hintText: 'Search Message...'),
                ),
                SizedBox(width: 16.w),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.tune_rounded, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 80.w,
                endIndent: 24.w,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(messages[index].id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    color: AppColors.error,
                    child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // Handle delete
                  },
                  child: MessageTile(
                    message: messages[index],
                    onTap: () => context.push('/messages/${messages[index].id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
