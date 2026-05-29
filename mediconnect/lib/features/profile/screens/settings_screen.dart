import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsGroup(context, 'Appearance', [
            _buildSettingsItem(context, 'Theme', 'System Default', Icons.dark_mode_outlined),
            _buildSettingsItem(context, 'Font Size', 'Medium', Icons.text_fields),
          ]),
          const SizedBox(height: 25),
          _buildSettingsGroup(context, 'Preferences', [
            _buildSettingsItem(context, 'Language', 'English (US)', Icons.language),
            _buildSettingsItem(context, 'Currency', 'USD (\$)', Icons.monetization_on_outlined),
          ]),
          const SizedBox(height: 25),
          _buildSettingsGroup(context, 'Notifications', [
            _buildToggleItem(context, 'Push Notifications', true),
            _buildToggleItem(context, 'Email Updates', false),
          ]),
          const SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text('Sign Out', style: TextStyle(color: colorScheme.error, fontWeight: FontWeight.bold)),
            ),
          ),
          Center(child: Text('Version 1.0.0', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
        ),
        Container(
          decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title, String value, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colorScheme.onSurface),
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(color: colorScheme.onSurfaceVariant)),
          Icon(Icons.arrow_forward_ios, size: 14, color: colorScheme.onSurfaceVariant),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildToggleItem(BuildContext context, String title, bool value) {
    final colorScheme = Theme.of(context).colorScheme;
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
      value: value,
      onChanged: (v) {},
      activeColor: colorScheme.primary,
    );
  }
}
