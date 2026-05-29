import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSecurityCard(context),
          const SizedBox(height: 30),
          _buildPrivacyGroup(context, 'Access Control', [
            _buildToggleItem(context, 'Biometric Login', true),
            _buildToggleItem(context, 'Two-Factor Auth', false),
          ]),
          const SizedBox(height: 25),
          _buildPrivacyGroup(context, 'Data Sharing', [
            _buildToggleItem(context, 'Share with Insurance', true),
            _buildToggleItem(context, 'Public Health Research', true),
            _buildToggleItem(context, 'Third-party Sync', false),
          ]),
          const SizedBox(height: 40),
          _buildSecurityAction(context, 'Activity Log', Icons.history),
          _buildSecurityAction(context, 'Delete My Data', Icons.delete_outline, color: colorScheme.error),
        ],
      ),
    );
  }

  Widget _buildSecurityCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user, color: colorScheme.secondary, size: 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your data is secure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.secondary)),
                Text('MediConnect uses end-to-end encryption to protect your health records.', style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyGroup(BuildContext context, String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        ),
        Container(
          decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
          child: Column(children: items),
        ),
      ],
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

  Widget _buildSecurityAction(BuildContext context, String title, IconData icon, {Color? color}) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: color ?? colorScheme.onSurface),
      title: Text(title, style: TextStyle(color: color ?? colorScheme.onSurface)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onSurfaceVariant),
      onTap: () {},
    );
  }
}
