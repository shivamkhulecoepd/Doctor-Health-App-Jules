import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class PrescriptionManagementScreen extends StatelessWidget {
  const PrescriptionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescriptions')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildPrescriptionCard();
        },
      ),
    );
  }

  Widget _buildPrescriptionCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Amoxicillin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('Active', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text('500mg • 2 times a day', style: TextStyle(color: AppColors.textSecondary)),
          const Divider(height: 30),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              const Text('Dr. Marcus Horizon', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const Spacer(),
              const Icon(Icons.event_note_outlined, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              const Text('Ends in 5 days', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Request Refill'),
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.qr_code_scanner, color: AppColors.primary),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
