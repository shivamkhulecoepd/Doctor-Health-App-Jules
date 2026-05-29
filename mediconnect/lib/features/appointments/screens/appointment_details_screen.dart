import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String id;
  const AppointmentDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 25),
            _buildDoctorInfo(context),
            const SizedBox(height: 25),
            _buildLocationCard(context),
            const SizedBox(height: 25),
            Text('Preparation Checklist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
            const SizedBox(height: 15),
            _buildChecklistItem(context, 'Bring your medical reports', true),
            _buildChecklistItem(context, 'Arrive 10 minutes early', true),
            _buildChecklistItem(context, 'Wear comfortable clothing', false),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Add to Calendar'),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
              child: Text('Need to cancel? Contact Clinic', style: TextStyle(color: colorScheme.error)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appointment Confirmed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.secondary)),
                Text('We are looking forward to seeing you!', style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=doc1')),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Marcus Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
              Text('Cardiologist • Heart Specialist', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.location_on, color: Colors.blue),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text('Central Clinic, 123 Health St, Medical District, NY 10001', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(height: 120, color: colorScheme.surfaceVariant.withOpacity(0.3), child: Center(child: Text('Map View Placeholder', style: TextStyle(color: colorScheme.onSurfaceVariant)))),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(BuildContext context, String text, bool isChecked) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(isChecked ? Icons.check_circle : Icons.circle_outlined, color: isChecked ? colorScheme.primary : colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: isChecked ? colorScheme.onSurface : colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
