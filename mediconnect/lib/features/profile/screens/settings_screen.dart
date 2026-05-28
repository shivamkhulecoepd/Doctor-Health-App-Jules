import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsGroup('Appearance', [
            _buildSettingsItem('Theme', 'System Default', Icons.dark_mode_outlined),
            _buildSettingsItem('Font Size', 'Medium', Icons.text_fields),
          ]),
          const SizedBox(height: 25),
          _buildSettingsGroup('Preferences', [
            _buildSettingsItem('Language', 'English (US)', Icons.language),
            _buildSettingsItem('Currency', 'USD (\$)', Icons.monetization_on_outlined),
          ]),
          const SizedBox(height: 25),
          _buildSettingsGroup('Notifications', [
            _buildToggleItem('Push Notifications', true),
            _buildToggleItem('Email Updates', false),
          ]),
          const SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            ),
          ),
          const Center(child: Text('Version 1.0.0', style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: AppColors.textSecondary)),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildToggleItem(String title, bool value) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (v) {},
      activeColor: AppColors.primary,
    );
  }
}
