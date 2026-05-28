import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSecurityCard(),
          const SizedBox(height: 30),
          _buildPrivacyGroup('Access Control', [
            _buildToggleItem('Biometric Login', true),
            _buildToggleItem('Two-Factor Auth', false),
          ]),
          const SizedBox(height: 25),
          _buildPrivacyGroup('Data Sharing', [
            _buildToggleItem('Share with Insurance', true),
            _buildToggleItem('Public Health Research', true),
            _buildToggleItem('Third-party Sync', false),
          ]),
          const SizedBox(height: 40),
          _buildSecurityAction('Activity Log', Icons.history),
          _buildSecurityAction('Delete My Data', Icons.delete_outline, color: AppColors.error),
        ],
      ),
    );
  }

  Widget _buildSecurityCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_user, color: AppColors.secondary, size: 40),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your data is secure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.secondary)),
                Text('MediConnect uses end-to-end encryption to protect your health records.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(children: items),
        ),
      ],
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

  Widget _buildSecurityAction(String title, IconData icon, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
