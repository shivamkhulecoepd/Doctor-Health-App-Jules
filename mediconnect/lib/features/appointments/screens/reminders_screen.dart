import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';

class RemindersSettingsScreen extends StatelessWidget {
  const RemindersSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        children: [
          FadeInUp(child: _buildSectionHeader(context, 'Appointment Reminders')),
          FadeInUp(delay: const Duration(milliseconds: 100), child: _buildReminderGroup(context, [
            {'title': '1 Day Before', 'value': true},
            {'title': '2 Hours Before', 'value': true},
            {'title': '30 Minutes Before', 'value': false},
          ])),
          SizedBox(height: 32.h),
          FadeInUp(delay: const Duration(milliseconds: 200), child: _buildSectionHeader(context, 'Medication Reminders')),
          FadeInUp(delay: const Duration(milliseconds: 300), child: _buildReminderGroup(context, [
            {'title': 'Morning Dose', 'value': true},
            {'title': 'Afternoon Dose', 'value': false},
            {'title': 'Evening Dose', 'value': true},
          ])),
          SizedBox(height: 32.h),
          FadeInUp(delay: const Duration(milliseconds: 400), child: _buildSectionHeader(context, 'Health Goals')),
          FadeInUp(delay: const Duration(milliseconds: 500), child: _buildReminderGroup(context, [
            {'title': 'Daily Steps Goal', 'value': true},
            {'title': 'Water Intake', 'value': false},
            {'title': 'Sleep Tracker', 'value': true},
          ])),
          SizedBox(height: 40.h),
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: GlassCard(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Notification Tone', style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600)),
                subtitle: Text('Default (Medical Chime)', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp)),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 16.h),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildReminderGroup(BuildContext context, List<Map<String, dynamic>> items) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.map((item) {
          final isLast = items.indexOf(item) == items.length - 1;
          return Column(
            children: [
              _buildReminderToggle(context, item['title'], item['value']),
              if (!isLast) Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5), indent: 20.w, endIndent: 20.w),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReminderToggle(BuildContext context, String title, bool value) {
    final colorScheme = Theme.of(context).colorScheme;
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 15.sp)),
      value: value,
      onChanged: (v) {},
      activeColor: colorScheme.primary,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
    );
  }
}
