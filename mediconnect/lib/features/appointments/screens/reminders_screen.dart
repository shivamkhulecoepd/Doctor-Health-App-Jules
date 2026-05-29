import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class RemindersSettingsScreen extends StatelessWidget {
  const RemindersSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader(context, 'Appointment Reminders'),
          _buildReminderToggle(context, '1 Day Before', true),
          _buildReminderToggle(context, '2 Hours Before', true),
          _buildReminderToggle(context, '30 Minutes Before', false),
          const SizedBox(height: 30),
          _buildSectionHeader(context, 'Medication Reminders'),
          _buildReminderToggle(context, 'Morning Dose', true),
          _buildReminderToggle(context, 'Afternoon Dose', false),
          _buildReminderToggle(context, 'Evening Dose', true),
          const SizedBox(height: 30),
          _buildSectionHeader(context, 'Health Goals'),
          _buildReminderToggle(context, 'Daily Steps Goal', true),
          _buildReminderToggle(context, 'Water Intake', false),
          _buildReminderToggle(context, 'Sleep Tracker', true),
          const SizedBox(height: 40),
          ListTile(
            title: Text('Notification Tone', style: TextStyle(color: colorScheme.onSurface)),
            subtitle: Text('Default (Medical Chime)', style: TextStyle(color: colorScheme.onSurfaceVariant)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.primary)),
    );
  }

  Widget _buildReminderToggle(BuildContext context, String title, bool value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(16)),
      child: SwitchListTile(
        title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
        value: value,
        onChanged: (v) {},
        activeColor: colorScheme.primary,
      ),
    );
  }
}
