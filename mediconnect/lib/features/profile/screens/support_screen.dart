import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 30),
            _buildFAQSection(context),
            const SizedBox(height: 30),
            _buildContactOptions(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: 'Search for help...',
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
        const SizedBox(height: 15),
        _buildExpansionTile(context, 'How to book an appointment?', 'Go to the search screen, find your preferred doctor, and click on the "Book Now" button.'),
        _buildExpansionTile(context, 'Is my data secure?', 'Yes, we use the latest encryption standards to ensure your medical data is safe and private.'),
        _buildExpansionTile(context, 'Can I cancel an appointment?', 'Yes, you can cancel any appointment up to 24 hours before the scheduled time from the My Appointments screen.'),
      ],
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, String content) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
        iconColor: colorScheme.onSurface,
        collapsedIconColor: colorScheme.onSurfaceVariant,
        children: [Padding(padding: const EdgeInsets.all(15), child: Text(content, style: TextStyle(color: colorScheme.onSurfaceVariant)))],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context) {
    return Row(
      children: [
        _buildContactCard(context, 'Email Support', Icons.mail_outline, Colors.blue),
        const SizedBox(width: 15),
        _buildContactCard(context, 'Call Us', Icons.phone_outlined, Colors.green),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context, String title, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
