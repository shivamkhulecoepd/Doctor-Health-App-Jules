import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 30),
            _buildFAQSection(),
            const SizedBox(height: 30),
            _buildContactOptions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for help...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildExpansionTile('How to book an appointment?', 'Go to the search screen, find your preferred doctor, and click on the "Book Now" button.'),
        _buildExpansionTile('Is my data secure?', 'Yes, we use the latest encryption standards to ensure your medical data is safe and private.'),
        _buildExpansionTile('Can I cancel an appointment?', 'Yes, you can cancel any appointment up to 24 hours before the scheduled time from the My Appointments screen.'),
      ],
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        children: [Padding(padding: const EdgeInsets.all(15), child: Text(content, style: const TextStyle(color: AppColors.textSecondary)))],
      ),
    );
  }

  Widget _buildContactOptions() {
    return Row(
      children: [
        _buildContactCard('Email Support', Icons.mail_outline, Colors.blue),
        const SizedBox(width: 15),
        _buildContactCard('Call Us', Icons.phone_outlined, Colors.green),
      ],
    );
  }

  Widget _buildContactCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
