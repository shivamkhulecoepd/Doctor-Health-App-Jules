import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class RemindersSettingsScreen extends StatelessWidget {
  const RemindersSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('Appointment Reminders'),
          _buildReminderToggle('1 Day Before', true),
          _buildReminderToggle('2 Hours Before', true),
          _buildReminderToggle('30 Minutes Before', false),
          const SizedBox(height: 30),
          _buildSectionHeader('Medication Reminders'),
          _buildReminderToggle('Morning Dose', true),
          _buildReminderToggle('Afternoon Dose', false),
          _buildReminderToggle('Evening Dose', true),
          const SizedBox(height: 30),
          _buildSectionHeader('Health Goals'),
          _buildReminderToggle('Daily Steps Goal', true),
          _buildReminderToggle('Water Intake', false),
          _buildReminderToggle('Sleep Tracker', true),
          const SizedBox(height: 40),
          const ListTile(
            title: Text('Notification Tone'),
            subtitle: Text('Default (Medical Chime)'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
    );
  }

  Widget _buildReminderToggle(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: (v) {},
        activeColor: AppColors.primary,
      ),
    );
  }
}
