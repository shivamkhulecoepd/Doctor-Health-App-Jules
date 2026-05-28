import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String id;
  const AppointmentDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointment Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 25),
            _buildDoctorInfo(),
            const SizedBox(height: 25),
            _buildLocationCard(),
            const SizedBox(height: 25),
            const Text('Preparation Checklist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _buildChecklistItem('Bring your medical reports', true),
            _buildChecklistItem('Arrive 10 minutes early', true),
            _buildChecklistItem('Wear comfortable clothing', false),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Add to Calendar'),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
              child: const Text('Need to cancel? Contact Clinic', style: TextStyle(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Appointment Confirmed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.secondary)),
              Text('We are looking forward to seeing you!', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=doc1')),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Marcus Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('Cardiologist • Heart Specialist', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.location_on, color: Colors.blue),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Text('Central Clinic, 123 Health St, Medical District, NY 10001', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(height: 120, color: Colors.grey[200], child: const Center(child: Text('Map View Placeholder'))),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String text, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(isChecked ? Icons.check_circle : Icons.circle_outlined, color: isChecked ? AppColors.primary : Colors.grey),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: isChecked ? AppColors.textPrimary : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
